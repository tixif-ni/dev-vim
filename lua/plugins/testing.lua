return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- .NET adapter built on vstest, so NUnit, xUnit and MSTest all work.
            "nsidorenco/neotest-vstest",
        },
        config = function()
            -- Must be set before the adapter is required. It gives up waiting
            -- for results after 2.5 minutes by default and then throws ENOENT
            -- on the missing result file, which long E2E runs easily exceed.
            vim.g.neotest_vstest = {
                timeout_ms = 60 * 60 * 1000,
                build_opts = {
                    -- Let the MSBuild worker nodes exit after each build
                    -- instead of idling with their memory for 15 minutes.
                    additional_args = { "-nodeReuse:false" },
                },
            }

            local nio = require("nio")

            -- Starting neotest builds the whole solution, which is what
            -- makes the first run so slow. Skip that and build only the
            -- test project of the file being opened (see below).
            local dotnet_utils = require("neotest-vstest.dotnet_utils")
            local build_path = dotnet_utils.build_path
            dotnet_utils.build_path = function(path)
                if path:match("%.slnx?$") then
                    return true
                end

                return build_path(path)
            end

            -- The adapter keeps a runner (dotnet fsi + vstest.console +
            -- testhost, several hundred MB) alive per test project for the
            -- whole session. Replace it with one that is shut down once
            -- nothing has used it for a while and comes back on demand.
            local idle_ms = 60 * 1000
            local runners = {}
            local busy = 0
            local generation = 0

            local function kill_tree(pid)
                for _, child in ipairs(vim.api.nvim_get_proc_children(pid)) do
                    kill_tree(child)
                end
                vim.uv.kill(pid, "sigkill")
            end

            local function activity_started()
                busy = busy + 1
                generation = generation + 1
            end

            local function activity_finished()
                busy = math.max(busy - 1, 0)
                generation = generation + 1

                local scheduled = generation
                vim.defer_fn(function()
                    if busy == 0 and scheduled == generation then
                        for _, runner in ipairs(runners) do
                            if not runner.pinned then
                                runner.stop()
                            end
                        end
                    end
                end, idle_ms)
            end

            local cli_wrapper = require("neotest-vstest.vstest.cli_wrapper")
            local runner_command
            cli_wrapper.create_test_runner = function()
                nio.scheduler()
                if not runner_command then
                    local script = vim.iter(vim.api.nvim_get_runtime_file("scripts/run_tests.fsx", true))
                        :find(function(path)
                            return path:match("neotest%-vstest") ~= nil
                        end)
                    runner_command = { "dotnet", "fsi", script, cli_wrapper.get_vstest_path() }
                end

                local process
                local discover_args
                local lock = nio.control.semaphore(1)
                local runner = {}

                runner.execute = function(content)
                    lock.with(function()
                        local is_discover = content:match("^discover ") ~= nil
                        if is_discover then
                            discover_args = content:match("^discover %S+ %S+ (.+)$")
                        elseif content:match("^debug%-tests ") then
                            -- A debug session is not tracked; never reap it.
                            runner.pinned = true
                        end

                        if not process then
                            nio.scheduler()
                            local started
                            started = vim.system(
                                runner_command,
                                { stdin = true, stdout = false, stderr = false },
                                function()
                                    if process == started then
                                        process = nil
                                    end
                                end
                            )
                            process = started

                            -- The runner only knows the tests it discovered
                            -- itself, so a fresh one has to discover again
                            -- before it can run anything.
                            if discover_args and not is_discover then
                                local wait_file = nio.fn.tempname()
                                started:write(
                                    ("discover %s %s %s\n"):format(nio.fn.tempname(), wait_file, discover_args)
                                )
                                cli_wrapper.spin_lock_wait_file(wait_file, vim.g.neotest_vstest.timeout_ms)
                            end
                        end

                        if process then
                            process:write(content .. "\n")
                        end
                    end)
                end

                runner.stop = function()
                    local running = process
                    process = nil
                    if running then
                        kill_tree(running.pid)
                    end
                end

                table.insert(runners, runner)

                return runner
            end

            vim.api.nvim_create_autocmd("VimLeavePre", {
                group = vim.api.nvim_create_augroup("NeotestStopRunners", {}),
                callback = function()
                    for _, runner in ipairs(runners) do
                        runner.stop()
                    end
                end,
            })

            -- Shut the runners down now instead of waiting for the idle
            -- minute. Not during a run: neotest would wait for results
            -- that never come.
            vim.api.nvim_create_user_command("TestRelease", function()
                if busy > 0 then
                    vim.notify("Tests are still running; stop them first", vim.log.levels.WARN)
                    return
                end

                generation = generation + 1
                for _, runner in ipairs(runners) do
                    runner.stop()
                end
                vim.notify("Test runners stopped")
            end, { desc = "Stop the idle test runner processes" })

            local vstest_client = require("neotest-vstest.vstest.client")
            local discover_tests_in_project = vstest_client.discover_tests_in_project
            vstest_client.discover_tests_in_project = function(...)
                activity_started()
                local ok, tests = pcall(discover_tests_in_project, ...)
                activity_finished()
                if not ok then
                    error(tests, 0)
                end

                return tests
            end

            -- The adapter's stop only closes its output streams: the tests
            -- keep running and a second stop throws "Future already set".
            -- Kill the test host instead. vstest reports the run as aborted,
            -- so neotest finishes normally.
            local function kill_test_hosts(pid)
                for _, child in ipairs(vim.api.nvim_get_proc_children(pid)) do
                    kill_test_hosts(child)

                    local command = vim.fn.system({ "ps", "-o", "command=", "-p", tostring(child) })
                    if command:match("testhost") then
                        vim.uv.kill(child, "sigkill")
                    end
                end
            end

            local run_strategy = require("neotest-vstest.strategies.vstest")
            package.loaded["neotest-vstest.strategies.vstest"] = function(spec)
                activity_started()
                local ok, process = pcall(run_strategy, spec)
                if not ok then
                    activity_finished()
                    error(process, 0)
                end

                process.stop = function()
                    kill_test_hosts(vim.fn.getpid())
                end

                local result = process.result
                local finished = false
                process.result = function()
                    local code = result()
                    if not finished then
                        finished = true
                        activity_finished()
                    end

                    return code
                end

                return process
            end

            -- The adapter asks for a runner for the project of every file it
            -- is asked about. With discovery off neotest asks about every
            -- buffer, which includes the thousands of unlisted ones Roslyn
            -- adds for diagnostics all over the solution. Only answer for
            -- files in the buffer list, which are the ones you opened.
            -- Creating a runner yields before the adapter caches it, so two
            -- lookups for the same project at once start two runners and the
            -- run hangs. Let one lookup finish before the next begins, and
            -- build the project the first time it is needed.
            local client_discovery = require("neotest-vstest.client")
            local get_client_for_project = client_discovery.get_client_for_project
            local client_lock = nio.control.semaphore(1)
            local built = {}
            client_discovery.get_client_for_project = function(project, solution)
                local client
                client_lock.with(function()
                    if project and project.is_test_project and not built[project.proj_file] then
                        built[project.proj_file] = true
                        build_path(project.proj_file)
                    end

                    client = get_client_for_project(project, solution)
                end)

                return client
            end

            -- When Neovim starts above several repositories the adapter finds
            -- every solution below the working directory and asks which one
            -- to use. Take the one closest above the current file instead;
            -- it still asks when there is none.
            local function select_solution(solutions)
                if vim.in_fast_event() then
                    nio.scheduler()
                end

                local by_dir = {}
                for _, solution in ipairs(solutions) do
                    by_dir[vim.fs.dirname(solution)] = by_dir[vim.fs.dirname(solution)] or solution
                end

                for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
                    if by_dir[dir] then
                        return by_dir[dir]
                    end
                end
            end

            -- A function cannot live in vim.g, so add it to the config the
            -- adapter reads when it is created just below.
            local vstest_config = require("neotest-vstest.config")
            local get_config = vstest_config.get_config
            vstest_config.get_config = function()
                local config = get_config()
                config.solution_selector = select_solution

                return config
            end

            local adapter = require("neotest-vstest")
            local is_test_file = adapter.is_test_file
            adapter.is_test_file = function(file_path)
                -- neotest also calls this from libuv callbacks, where
                -- Vimscript functions are not allowed.
                if vim.in_fast_event() then
                    require("nio").scheduler()
                end

                -- Not "loaded": neotest asks on BufAdd, before the file is
                -- read, and a "no" there keeps the file out of the tree.
                local bufnr = vim.fn.bufnr(file_path)
                if bufnr == -1 or not vim.bo[bufnr].buflisted then
                    return false
                end

                return is_test_file(file_path)
            end

            -- Bold dark green, amber, red and blue for passed, running,
            -- failed and skipped tests; the default light colours are faint
            -- on a light theme.
            local function set_highlights()
                vim.api.nvim_set_hl(0, "TestPassed", { fg = "#116329", bold = true })
                vim.api.nvim_set_hl(0, "TestRunning", { fg = "#9a6700", bold = true })
                vim.api.nvim_set_hl(0, "TestFailed", { fg = "#a40e26", bold = true })
                vim.api.nvim_set_hl(0, "TestSkipped", { fg = "#0550ae", bold = true })
            end
            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("NeotestHighlights", {}),
                callback = set_highlights,
            })
            set_highlights()

            require("neotest").setup({
                -- Only look for tests in open files, not the whole solution.
                discovery = {
                    enabled = false,
                },
                highlights = {
                    -- Plain text colour for directories, projects and files
                    -- in the summary; the default bright cyan is hard to
                    -- read on a light theme. The adapter reports .csproj
                    -- entries as files, so both are needed.
                    dir = "Normal",
                    file = "Normal",
                    passed = "TestPassed",
                    running = "TestRunning",
                    failed = "TestFailed",
                    skipped = "TestSkipped",
                },
                adapters = {
                    adapter,
                },
            })
        end,
        -- Same layout as the Pytest mappings in ftplugin/python.vim.
        keys = {
            {
                "<localleader>tm",
                function()
                    require("neotest").run.run()
                end,
                ft = { "cs" },
                desc = "[Test] Nearest test (or class, on a class line)",
            },
            {
                "<localleader>ta",
                function()
                    require("neotest").run.run(vim.fn.expand("%:p"))
                end,
                ft = { "cs" },
                desc = "[Test] File",
            },
            {
                "<localleader>tp",
                function()
                    require("neotest").run.run(vim.fn.getcwd())
                end,
                ft = { "cs" },
                desc = "[Test] Project",
            },
            {
                "<localleader>tl",
                function()
                    require("neotest").run.run_last()
                end,
                ft = { "cs" },
                desc = "[Test] Re-run last",
            },
            {
                "<localleader>tx",
                function()
                    require("neotest").run.stop()
                end,
                ft = { "cs" },
                desc = "[Test] Stop",
            },
            {
                "<localleader>tq",
                "<cmd>TestRelease<cr>",
                ft = { "cs" },
                desc = "[Test] Stop the idle test runners",
            },
            {
                "<localleader>to",
                function()
                    require("neotest").output.open({ enter = true, auto_close = true })
                end,
                ft = { "cs" },
                desc = "[Test] Show output",
            },
            {
                "<localleader>ts",
                function()
                    require("neotest").summary.toggle()
                end,
                ft = { "cs" },
                desc = "[Test] Toggle summary",
            },
        },
    },
}

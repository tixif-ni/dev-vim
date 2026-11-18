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
            }

            -- The adapter's stop only closes its output streams: the tests
            -- keep running and a second stop throws "Future already set".
            -- Kill the test host instead. vstest reports the run as aborted,
            -- so neotest finishes normally and the runner stays alive.
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
                local process = run_strategy(spec)
                process.stop = function()
                    kill_test_hosts(vim.fn.getpid())
                end

                return process
            end

            require("neotest").setup({
                highlights = {
                    -- Plain text colour for directories, projects and files
                    -- in the summary; the default bright cyan is hard to
                    -- read on a light theme. The adapter reports .csproj
                    -- entries as files, so both are needed.
                    dir = "Normal",
                    file = "Normal",
                },
                adapters = {
                    require("neotest-vstest"),
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

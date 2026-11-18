--- Finds the SQL statement the cursor is on.
--- @return number|nil start_line First line of the statement (1-indexed).
--- @return number|nil end_line Last line of the statement (1-indexed).
local function statement_under_cursor()
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1

    local ok, parser = pcall(vim.treesitter.get_parser, 0, "sql")
    if ok and parser then
        local tree = parser:parse()[1]
        for node in tree:root():iter_children() do
            local start_row, _, end_row, end_col = node:range()
            -- A node ending at column 0 does not really reach that row.
            if end_col == 0 and end_row > start_row then
                end_row = end_row - 1
            end

            if node:type() == "statement" and start_row <= row and row <= end_row then
                return start_row + 1, end_row + 1
            end
        end
    end

    -- No parser, or the cursor is not inside a statement: use the line itself.
    if vim.api.nvim_get_current_line():match("%S") then
        return row + 1, row + 1
    end
end

return {
    { "tpope/vim-dadbod", commit = "e95afed23712f969f83b4857a24cf9d59114c2e6" },
    {
        "radyz/vim-dadbod-wrapper",
        opts = {
            env_prefix = "DADBOD_",
        },
        ft = { "sql" },
        config = function(_, opts)
            local connection_manager = require("vim-dadbod-wrapper.connection-manager")

            -- The wrapper hands the URL straight to :DB and never exposes it,
            -- so vim-dadbod-completion has nothing to read. Record every URL
            -- as it is registered (from the environment or :DBLoadSecret) and
            -- keep `b:db` in sync with the last connection used in each buffer.
            local urls = {}
            local add = connection_manager.add
            connection_manager.add = function(connection, url)
                add(connection, url)

                if connection and connection ~= "" and url and url ~= "" then
                    urls[connection:lower()] = url
                end
            end

            require("vim-dadbod-wrapper").setup(opts)

            -- Point completion at a database. vim-dadbod-completion only reads
            -- `b:db` on FileType, so ask it to fetch again whenever it changes.
            local function set_connection(bufnr, url)
                vim.b[bufnr].db = url
                pcall(vim.fn["vim_dadbod_completion#fetch"], bufnr)
            end

            local exec = connection_manager.exec
            connection_manager.exec = function(connection, bufnr, range)
                -- Without a range the wrapper runs `:DB url < %`, which reads
                -- the file on disk: unsaved edits are ignored and a buffer
                -- that was never written returns nothing. Send the buffer.
                range = range or { start_line = 1, end_line = vim.api.nvim_buf_line_count(bufnr) }

                exec(connection, bufnr, range)

                if urls[connection] and vim.b[bufnr].db ~= urls[connection] then
                    set_connection(bufnr, urls[connection])
                end
            end

            -- Complete against the local database until a connection is picked.
            local function use_default_connection(bufnr)
                if urls["local"] and vim.b[bufnr].db == nil then
                    set_connection(bufnr, urls["local"])
                end
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "sql",
                group = vim.api.nvim_create_augroup("DadbodDefaultConnection", {}),
                callback = function(ev)
                    use_default_connection(ev.buf)
                end,
            })
            -- The buffer that triggered the load has already had its FileType event.
            use_default_connection(vim.api.nvim_get_current_buf())

            -- Repoint completion without running a query. With no argument it
            -- opens a picker.
            vim.api.nvim_create_user_command("DBUse", function(cmd)
                local bufnr = vim.api.nvim_get_current_buf()
                local function use(connection)
                    if not connection then
                        return
                    end
                    if not urls[connection] then
                        vim.notify("Connection is not registered: " .. connection, vim.log.levels.WARN)
                        return
                    end

                    set_connection(bufnr, urls[connection])
                    vim.notify("Completing against " .. connection)
                end

                if cmd.args ~= "" then
                    use(cmd.args:lower())
                else
                    vim.ui.select(connection_manager.list(), { prompt = "Complete against" }, use)
                end
            end, {
                nargs = "?",
                desc = "Choose the DB connection used for completion",
                complete = function()
                    return connection_manager.list()
                end,
            })
        end,
        keys = {
            {
                "<localleader>c",
                "<cmd>DBUse<cr>",
                ft = { "sql" },
                mode = { "n" },
                desc = "[DB] Choose completion connection",
            },
            {
                "<localleader>r",
                function()
                    -- In normal mode run only the statement under the cursor.
                    -- The picker reads its range from a visual selection, so
                    -- select the statement and let it take over from there.
                    if vim.api.nvim_get_mode().mode == "n" then
                        local start_line, end_line = statement_under_cursor()
                        if not start_line then
                            vim.notify("No query under the cursor", vim.log.levels.WARN)
                            return
                        end

                        vim.cmd(string.format("normal! %dGV%dG", start_line, end_line))
                    end

                    require("telescope").extensions.dadbod_wrapper.connections(
                        require("telescope.themes").get_dropdown({
                            initial_mode = "normal",
                        })
                    )
                end,
                ft = { "sql" },
                mode = { "n", "v" },
            },
            {
                "<localleader>p",
                function()
                    require("vim-dadbod-wrapper")
                end,
                ft = { "dboutpreview" },
                mode = { "n" },
            },
        },
    },
    {
        -- Table and column completion from the database in `b:db`.
        "kristijanhusak/vim-dadbod-completion",
        dependencies = { "tpope/vim-dadbod", "hrsh7th/nvim-cmp" },
        ft = { "sql" },
        config = function()
            local cmp = require("cmp")
            local sources = vim.deepcopy(cmp.get_config().sources)
            table.insert(sources, 1, { name = "vim-dadbod-completion" })

            cmp.setup.filetype("sql", { sources = sources })
        end,
    },
    {
        dir = vim.fn.stdpath("config") .. "/lua/local-plugins/pgsql-tools",
        keys = {
            {
                "<localleader><space>",
                function()
                    require("pgsql-tools").inspect()
                end,
                ft = { "dbout" },
                mode = "n",
                desc = "[PGSQL] Preview",
                noremap = true,
            },
        },
    },
}

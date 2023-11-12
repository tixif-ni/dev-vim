return {
    "https://github.com/christoomey/vim-tmux-navigator.git",
    "https://github.com/simeji/winresizer.git",
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        init = function()
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_refresh_slow = 1
        end,
        ft = "markdown",
    },
    {
        "rest-nvim/rest.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls.nvim",
        },
        opts = {
            result_split_horizontal = true,
            skip_ssl_verification = true,
            result = {
                show_curl_command = false,
            },
        },
        init = function()
            local null_ls = require("null-ls")
            local ts = require("vim.treesitter")
            local ts_utils = require("nvim-treesitter.ts_utils")

            null_ls.register({
                method = null_ls.methods.DIAGNOSTICS,
                filetypes = { "http" },
                generator = {
                    fn = function(params)
                        local diagnostics = {}
                        local parser = ts.get_parser(params.bufnr, params.filetype)
                        local root = parser:parse()[1]:root()

                        local query = ts.query.parse(params.filetype, "(request (method) @requestMethod)")
                        for _, node in query:iter_captures(root, params.bufnr) do
                            local row, col, _, end_col = ts_utils.get_vim_range({ node:range() }, params.bufnr)

                            table.insert(diagnostics, {
                                row = row,
                                col = col,
                                end_col = end_col + 1,
                                source = "http",
                                message = "This http request can be executed.",
                                severity = vim.diagnostic.severity.HINT,
                            })
                        end

                        return diagnostics
                    end,
                },
            })

            null_ls.register({
                method = null_ls.methods.CODE_ACTION,
                filetypes = { "http" },
                generator = {
                    fn = function(params)
                        local actions = {}

                        for _, diagnostic in ipairs(vim.diagnostic.get(params.bufnr, { lnum = params.row - 1 })) do
                            if
                                diagnostic.source == "http"
                                and params.col >= diagnostic.col
                                and params.col < diagnostic.end_col
                            then
                                table.insert(actions, {
                                    title = "Execute HTTP request",
                                    action = require("rest-nvim").run,
                                })
                            end
                        end

                        return actions
                    end,
                },
            })
        end,
    },
    {
        "sudormrfbin/cheatsheet.nvim",
        opts = {
            bundled_cheatsheets = false,
            bundled_plugin_cheatsheets = false,
        },
        cmd = "Cheatsheet",
    },
    {
        "lpoto/telescope-docker.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        commander = {
            {
                cat = "Docker",
                desc = "[Docker] Find container",
                cmd = ":Telescope docker theme=ivy<CR>",
            },
        },
        init = function()
            require("telescope").load_extension("docker")
        end,
    },
    {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        event = "VeryLazy",
        version = "2.*",
        opts = {},
    },
}

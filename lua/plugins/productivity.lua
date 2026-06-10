return {
    --"https://github.com/christoomey/vim-tmux-navigator.git",
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
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
        opts = {
            rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
        },
    },
    {
        "rest-nvim/rest.nvim",
        ft = "http",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls.nvim",
            "nvim-neotest/nvim-nio",
            "vhyrro/luarocks.nvim",
        },
        config = function()
            require("rest-nvim").setup({
                -- result_split_horizontal = true,
                skip_ssl_verification = true,
                result = {
                    -- show_curl_command = false,
                },
            })
        end,
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
        event = "VeryLazy",
        version = "2.*",
        config = function()
            require("window-picker").setup()
        end,
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
        version = "*",
        keys = {
            { "<leader>ngf", ":Neogen func<CR>", desc = "[Code] generates function doc", mode = "n" },
            { "<leader>ngc", ":Neogen class<CR>", desc = "[Code] generates class doc", mode = "n" },
            { "<leader>ngt", ":Neogen type<CR>", desc = "[Code] generates type docs", mode = "n" },
        },
    },
    {
        "zbirenbaum/copilot.lua",
        dependencies = "github/copilot.vim",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup()
            vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
        end,
    },
    {
        "greggh/claude-code.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", -- Required for git operations
        },
        config = function()
            require("claude-code").setup()
        end,
    },
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        opts = {
            terminal = {
                ---@module "snacks"
                ---@type snacks.win.Config|{}
                snacks_win_opts = {
                    position = "bottom",
                    height = 0.4,
                    width = 1.0,
                    border = "single",
                },
            },
        },
        keys = {
            { "<leader>a", nil, desc = "AI/Claude Code" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
            },
            -- Diff management
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
    },
}

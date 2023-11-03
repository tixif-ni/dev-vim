return {
    {
        "https://github.com/tpope/vim-fugitive.git",
        lazy = false,
        dependencies = {
            "https://github.com/tommcdo/vim-fugitive-blame-ext.git",
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            { "<leader>gb", ":Git blame<CR>", desc = "[Git] Annotate file", mode = "n" },
            { "<leader>gs", ":Git<CR>", desc = "[Git] Display status", mode = "n" },
            { "<leader>gr", ":Gread<CR>", desc = "[Git] Checkout file", mode = "n" },
            { "<leader>gl", ":Git log<CR>", desc = "[Git] Log", mode = "n" },
            { "<leader>gp", ":Git push<CR>", desc = "[Git] Push changes", mode = "n", ft = "fugitive" },
            { "<leader>gP", ":Git push --force<CR>", desc = "[Git] Push forced changes", mode = "n", ft = "fugitive" },
            {
                "<leader>gt",
                function()
                    require("telescope.builtin").git_branches(require("telescope.themes").get_dropdown({
                        cwd = vim.fn.substitute(vim.fn.FugitiveGitDir(), ".git", "", ""),
                        previewer = false,
                    }))
                end,
                desc = "[Git] Find branch",
                mode = "n",
                noremap = true,
            },
            {
                "fgf",
                function()
                    require("telescope.builtin").git_files(require("telescope.themes").get_dropdown({
                        cwd = vim.fn.substitute(vim.fn.FugitiveGitDir(), ".git", "", ""),
                        previewer = false,
                    }))
                end,
                desc = "[Git] Find file",
                mode = "n",
                noremap = true,
            },
            {
                "fgl",
                function()
                    require("telescope.builtin").live_grep({
                        cwd = vim.fn.substitute(vim.fn.FugitiveGitDir(), ".git", "", ""),
                    })
                end,
                desc = "[Git] Find text",
                mode = "n",
                noremap = true,
            },
            {
                "fgw",
                function()
                    require("telescope.builtin").grep_string({
                        initial_mode = "normal",
                        cwd = vim.fn.substitute(vim.fn.FugitiveGitDir(), ".git", "", ""),
                    })
                end,
                desc = "[Git] Find word",
                mode = "n",
                noremap = true,
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "radyz/telescope-gitsigns",
        },
        lazy = false,
        opts = {
            numhl = true,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })
            end,
        },
        keys = {
            { "fh", ":Telescope git_signs theme=ivy initial_mode=normal<CR>", desc = "[Git] File hunks", mode = "n" },
        },
        init = function()
            require("telescope").load_extension("git_signs")
        end,
    },
    {
        "https://github.com/rhysd/git-messenger.vim.git",
        keys = {
            { "<leader>gm", "<Plug>(GitMessenger)<CR>", desc = "[Git] Line history", mode = "n" },
        },
        init = function()
            vim.g.git_messenger_always_into_popup = true
        end,
    },
    {
        "ruanyl/vim-gh-line",
        keys = {
            { "<leader>gy", "<Plug>(gh-line)", desc = "[Git] Github url", mode = "n" },
        },
        init = function()
            -- Disable default mappings
            vim.g.gh_line_map_default = 0
            vim.g.gh_line_blame_map_default = 0

            vim.g.gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '
        end,
    },
    {
        "sindrets/diffview.nvim",
        lazy = false,
        dependencies = {
            "https://github.com/tpope/vim-fugitive.git",
        },
        opts = function()
            local actions = require("diffview.actions")

            return {
                keymaps = {
                    view = {
                        {
                            "n",
                            "gq",
                            "<CMD>DiffviewClose<CR>",
                            { desc = "Close the panel" },
                        },
                    },
                    file_panel = {
                        {
                            "n",
                            "gq",
                            "<CMD>DiffviewClose<CR>",
                            { desc = "Close the panel" },
                        },
                        {
                            "n",
                            "<c-d>",
                            actions.scroll_view(0.25),
                            { desc = "Scroll the view down" },
                        },
                        {
                            "n",
                            "<c-u>",
                            actions.scroll_view(-0.25),
                            { desc = "Scroll the view up" },
                        },
                        ["<c-f>"] = false,
                        ["<c-b>"] = false,
                    },
                    file_history_panel = {
                        {
                            "n",
                            "gq",
                            "<CMD>DiffviewClose<CR>",
                            { desc = "Close the panel" },
                        },
                        {
                            "n",
                            "<c-d>",
                            actions.scroll_view(0.25),
                            { desc = "Scroll the view down" },
                        },
                        {
                            "n",
                            "<c-u>",
                            actions.scroll_view(-0.25),
                            { desc = "Scroll the view up" },
                        },
                        ["<c-f>"] = false,
                        ["<c-b>"] = false,
                    },
                },
                default_args = {
                    DiffviewOpen = { "--imply-local" },
                },
            }
        end,
        keys = {
            { "<leader>gh", ":DiffviewFileHistory<CR>", desc = "[Git] History", mode = "n", remap = true },
            {
                "dd",
                ":DiffviewLine<CR>",
                mode = "n",
                desc = "[Git] Diff line",
                ft = { "git", "fugitiveblame" },
                noremap = true,
            },
            {
                "dh",
                ":DiffviewLine ..HEAD<CR>",
                mode = "n",
                desc = "[Git] Diff line..head",
                ft = { "git", "fugitiveblame" },
                noremap = true,
            },
        },
        commander = {
            {
                desc = "[Git] File history",
                cmd = ":DiffviewFileHistory %<CR>",
            },
            {
                desc = "[Git] PR review",
                cmd = ":DiffviewOpen origin/HEAD...HEAD<CR>",
            },
            {
                desc = "[Git] PR commits",
                cmd = ":DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges<CR>",
            },
            {
                desc = "[Git] PR file",
                cmd = ":DiffviewOpen origin/HEAD...HEAD -- %<CR>",
            },
            {
                desc = "[Git] PR file commits",
                cmd = ":DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges %<CR>",
            },
        },
        init = function()
            vim.api.nvim_create_user_command("DiffviewLine", function(opts)
                local git_utils = require("utils.git")
                local git_dir = vim.fn.substitute(vim.fn.FugitiveGitDir(), ".git", "", "")
                local hash_range = git_utils.get_line_hash_range(opts.args)

                vim.cmd(string.format("DiffviewOpen %s -C%s", hash_range, git_dir))
            end, { nargs = "?" })
        end,
    },
}

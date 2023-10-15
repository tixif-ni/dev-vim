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
            local utils = require("utils.text")

            local http_action_source = {
                method = null_ls.methods.CODE_ACTION,
                filetypes = { "http" },
                generator = {
                    fn = function(params)
                        local actions = {}
                        local line = params.content[params.row]

                        if
                            utils.startswith(line, "GET")
                            or utils.startswith(line, "POST")
                            or utils.startswith(line, "PUT")
                            or utils.startswith(line, "PATCH")
                            or utils.startswith(line, "DELETE")
                        then
                            table.insert(actions, {
                                title = "Execute HTTP request",
                                action = require("rest-nvim").run,
                            })
                        end

                        return actions
                    end,
                },
            }

            null_ls.register(http_action_source)
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
        "MattesGroeger/vim-bookmarks",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "https://github.com/tom-anders/telescope-vim-bookmarks.nvim.git",
        },
        keys = {
            { "mm", "<Plug>BookmarkToggle", desc = "[Bookmark] Toggle", mode = "n" },
            { "mi", "<Plug>BookmarkAnnotate", desc = "[Bookmark] Save", mode = "n" },
        },
        commander = {
            {
                cat = "Bookmark",
                desc = "[Bookmark] Find mark",
                cmd = ":Telescope vim_bookmarks all theme=ivy<CR>",
            },
            {
                cat = "Bookmark",
                desc = "[Bookmark] Find file mark",
                cmd = ":Telescope vim_bookmarks current_file theme=ivy<CR>",
            },
            {
                cat = "Bookmark",
                desc = "[Bookmark] Clear mark",
                cmd = ":BookmarkClearAll<CR>",
            },
            {
                cat = "Bookmark",
                desc = "[Bookmark] Clear file mark",
                cmd = ":BookmarkClear<CR>",
            },
        },
        init = function()
            vim.g.bookmark_no_default_key_mappings = 1
            vim.g.bookmark_save_per_working_dir = 1
            vim.g.bookmark_auto_save = 1

            require("telescope").load_extension("vim_bookmarks")
        end,
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
}

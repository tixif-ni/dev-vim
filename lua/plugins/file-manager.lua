return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope.nvim",
            "nvim-pack/nvim-spectre",
        },
        opts = {
            actions = {
                open_file = {
                    resize_window = false,
                },
            },
            filters = {
                dotfiles = true,
                custom = {
                    "^.git$",
                    "^.cache$",
                    ".pyc",
                    ".pyo",
                    "__pycache__",
                    "bower_components",
                    "DS_Store",
                },
            },
            diagnostics = {
                enable = true,
            },
            renderer = {
                indent_markers = {
                    enable = true,
                },
            },
            filesystem_watchers = {
                ignore_dirs = {
                    "node_modules",
                    ".venv",
                },
            },
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                local function wrap_cwd_context(f)
                    return function(node, ...)
                        node = node or require("nvim-tree.lib").get_node_at_cursor()

                        local cwd = "."
                        if node.type == "directory" then
                            cwd = node.absolute_path
                        elseif node.type == "file" then
                            cwd = node.parent.absolute_path
                        end

                        f(cwd, node, ...)
                    end
                end

                -- Note: Rather than calling default method to add all key-mappins, we are setting
                -- them individually to omit the ones that clash with telescope.
                --
                -- api.config.mappings.default_on_attach(bufnr)
                --
                -- BEGIN_DEFAULT_ON_ATTACH
                vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
                vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
                --vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
                vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
                vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
                vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
                vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
                vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
                vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
                vim.keymap.set("n", "<S-Tab>", api.node.open.preview_no_picker, opts("Open Preview: No Picker"))
                vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
                vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
                vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
                vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
                vim.keymap.set("n", "a", api.fs.create, opts("Create"))
                --vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
                --vim.keymap.set("n", "bt", api.marks.bulk.trash, opts("Trash Bookmarked"))
                --vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
                vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle Filter: No Buffer"))
                vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
                vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Filter: Git Clean"))
                vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
                vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
                vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
                vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
                vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
                vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
                vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
                vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
                --vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
                --vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
                vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
                vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
                vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
                vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
                vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
                --vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
                --vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
                vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
                vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
                vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
                vim.keymap.set("n", "q", api.tree.close, opts("Close"))
                vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
                vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
                vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
                --vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
                vim.keymap.set("n", "u", api.fs.rename_full, opts("Rename: Full Path"))
                vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Filter: Hidden"))
                vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
                vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
                vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
                vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
                vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
                -- END_DEFAULT_ON_ATTACH

                -- CUSTOM
                vim.keymap.set("n", "K", api.node.show_info_popup, opts("Info"), { noremap = true })
                vim.keymap.set("n", "f", function() end, opts("No op"))
                vim.keymap.set(
                    "n",
                    "ff",
                    wrap_cwd_context(function(cwd)
                        require("telescope.builtin").find_files({ cwd = cwd })
                    end),
                    opts("Find file")
                )
                vim.keymap.set(
                    "n",
                    "fl",
                    wrap_cwd_context(function(cwd)
                        require("telescope.builtin").live_grep({ cwd = cwd })
                    end),
                    opts("Find text")
                )

                vim.keymap.set(
                    "n",
                    "S",
                    wrap_cwd_context(function(cwd)
                        api.tree.close()
                        require("spectre").open_visual({ cwd = cwd })
                    end),
                    opts("Search & Replace")
                )
            end,
        },
        keys = {
            { "<leader>nt", ":NvimTreeToggle<CR>", desc = "[Tree] Toggle tree", mode = "n", noremap = true },
            { "<leader>nf", ":NvimTreeFindFile<CR>", desc = "[Tree] Find file", mode = "n", noremap = true },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        lazy = false,
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ["<C-n>"] = "nop",
                        ["<C-p>"] = "nop",
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                    },
                    n = {
                        ["q"] = "close",
                    },
                },
            },
            pickers = {
                buffers = {
                    mappings = {
                        n = {
                            ["dd"] = "delete_buffer",
                        },
                    },
                    theme = "ivy",
                },
                git_branches = {
                    theme = "ivy",
                    mappings = {
                        i = {
                            ["<c-a>"] = "nop",
                            ["<c-b>"] = "git_create_branch",
                        },
                        n = {
                            ["<c-a>"] = "nop",
                            ["<c-b>"] = "git_create_branch",
                        },
                    },
                },
                git_status = {
                    theme = "ivy",
                },
                diagnostics = {
                    theme = "ivy",
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        },
        keys = {
            { "ff", ":Telescope find_files<CR>", desc = "[File] Find file", mode = "n", noremap = true },
            { "fl", ":Telescope live_grep<CR>", desc = "[File] Find text", mode = "n", noremap = true },
            { "fw", ":Telescope grep_string<CR>", desc = "[File] Find word", mode = "n", noremap = true },
            { "fb", ":Telescope buffers<CR>", desc = "[File] Find buffer", mode = "n", noremap = true },
            {
                "fd",
                ":Telescope diagnostics bufnr=0 initial_mode=normal<CR>",
                desc = "[File] Find diagnostics",
                mode = "n",
                noremap = true,
            },
        },
        init = function()
            require("telescope").load_extension("fzf")

            -- Add line numbering to preview buffers
            vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
        end,
    },
    {
        "https://github.com/radyz/harpoon.git",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        branch = "feat/path-display-support",
        keys = {
            {
                "mf",
                function()
                    require("harpoon.mark").add_file()
                end,
                desc = "[File] Add mark",
                mode = "n",
                noremap = true,
            },
            {
                "fm",
                function()
                    require("telescope").extensions.harpoon.marks(require("telescope.themes").get_ivy({
                        initial_mode = "normal",
                        path_display = {
                            shorten = { len = 1, exclude = { 1, -1, -2 } },
                        },
                    }))
                end,
                desc = "[File] Find mark",
                mode = "n",
                noremap = true,
            },
        },
    },
}

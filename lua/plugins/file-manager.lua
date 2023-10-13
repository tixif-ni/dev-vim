local utils = require("utils.git")

local set_git_root = function(opts)
	opts = opts or {}
	if opts.cwd == nil or opts.cwd == "" then
		opts.cwd = utils.get_git_root()
	end

	if opts.cwd == nil or opts.cwd == "" then
		error("Not a git repository")
	end

	return opts
end

return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
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
		},
		keys = {
			{ "<leader>nt", ":NvimTreeToggle<CR>", desc = "[Tree] Toggle tree", mode = "n", noremap = true },
			{ "<leader>nf", ":NvimTreeFindFile<CR>", desc = "[Tree] Find file", mode = "n", noremap = true },
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"smilovanovic/telescope-search-dir-picker.nvim",
		},
		opts = function()
			return {
				defaults = {
					mappings = {
						i = {
							["<C-n>"] = false,
							["<C-p>"] = false,
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
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
					lsp_references = {
						show_line = false,
						theme = "ivy",
					},
					lsp_definitions = {
						show_line = false,
						theme = "ivy",
					},
					lsp_implementations = {
						show_line = false,
						theme = "ivy",
					},
					git_branches = {
						theme = "ivy",
					},
					git_status = {
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
			}
		end,
		keys = {
			{ "<leader>ff", ":Telescope find_files<CR>", desc = "[File] Find file", mode = "n", noremap = true },
			{ "<leader>fl", ":Telescope search_dir_picker<CR>", desc = "[File] Find text", mode = "n", noremap = true },
			{ "<leader>fw", ":Telescope grep_string<CR>", desc = "[File] Find word", mode = "n", noremap = true },
			{ "<leader>fb", ":Telescope buffers<CR>", desc = "[File] Find buffer", mode = "n", noremap = true },
			{
				"<leader>fgf",
				function()
					require("telescope.builtin").git_files(set_git_root())
				end,
				desc = "[Git] Find file",
				mode = "n",
				noremap = true,
			},
			{
				"<leader>fgl",
				function()
					require("telescope.builtin").live_grep(set_git_root())
				end,
				desc = "[Git] Find text",
				mode = "n",
				noremap = true,
			},
			{
				"<leader>fgw",
				function()
					require("telescope.builtin").grep_string(set_git_root())
				end,
				desc = "[Git] Find word",
				mode = "n",
				noremap = true,
			},
			{
				"<leader>fgc",
				function()
					require("telescope.builtin").git_commits(set_git_root())
				end,
				desc = "[Git] Find log",
				mode = "n",
				noremap = true,
			},
			{
				"<leader>fgb",
				function()
					require("telescope.builtin").git_branches(set_git_root())
				end,
				desc = "[Git] Find branch",
				mode = "n",
				noremap = true,
			},
		},
		commander = {
			{
				desc = "[Git] Buffer commits",
				cmd = function()
					require("telescope.builtin").git_bcommits(set_git_root())
				end,
			},
			{
				desc = "[Git] Display status",
				cmd = function()
					require("telescope.builtin").git_status(set_git_root())
				end,
			},
		},
		init = function()
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("search_dir_picker")
		end,
	},
}

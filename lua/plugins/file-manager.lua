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
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				opts = {
					filter_rules = {
						include_current_win = false,
						autoselect_one = true,
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { "neo-tree", "neo-tree-popup", "notify" },
							-- if the buffer type is one of following, the window will be ignored
							buftype = { "terminal", "quickfix" },
						},
					},
				},
			},
		},
		opts = {
			window = {
				mappings = {
					["S"] = "split_with_window_picker",
					["s"] = "vsplit_with_window_picker",
				},
			},
			filesystem = {
				use_libuv_file_watcher = true,
				filtered_items = {
					never_show = {
						".git",
						".cache",
						".pyc",
						".pyo",
						".vscode",
						"__pycache__",
						"bower_components",
						".DS_Store",
					},
				},
			},
		},
		-- TODO: fugitive integration to open in tree from git status
		keys = {
			{ "<leader>nt", ":Neotree filesystem toggle<CR>", desc = "Toggles tree display", mode = "n" },
			{ "<leader>nf", ":Neotree filesystem reveal<CR>", desc = "Finds file in tree", mode = "n" },
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"https://github.com/tom-anders/telescope-vim-bookmarks.nvim.git",
			"nvim-telescope/telescope-ui-select.nvim",
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
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			}
		end,
		keys = {
			{ "<leader>ff", ":Telescope find_files<CR>" },
			{ "<leader>fl", ":Telescope live_grep<CR>" },
			{ "<leader>fw", ":Telescope grep_string<CR>" },
			{ "<leader>fb", ":Telescope buffers<CR>" },
			{ "<leader>fgf", ":Telescope git_files<CR>" },
			{
				"<leader>fgl",
				function()
					return require("telescope.builtin").live_grep(set_git_root())
				end,
			},
			{
				"<leader>fgw",
				function()
					return require("telescope.builtin").grep_string(set_git_root())
				end,
			},
			{
				"<leader>fdl",
				function()
					return require("telescope.builtin").live_grep({
						cwd = vim.fn.expand("%:p:h"),
					})
				end,
			},
			{
				"<leader>fdw",
				function()
					return require("telescope.builtin").grep_string({
						cwd = vim.fn.expand("%:p:h"),
					})
				end,
			},
			{ "<leader>fgc", "<cmd>Telescope git_commits<cr>" },
			{ "<leader>fma", "<cmd>Telescope vim_bookmarks all<cr>" },
			{ "<leader>fmf", "<cmd>Telescope vim_bookmarks current_file<cr>" },
			{ "<leader>fdf", "<cmd>Telescope lsp_document_diagnostics<cr>" },
			{ "<leader>fda", "<cmd>Telescope lsp_workspace_diagnostics<cr>" },
		},
		init = function()
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("vim_bookmarks")
			require("telescope").load_extension("ui-select")

			-- Git pickers
			-- Setup multiple folder awareness
			local git_pickers = require("telescope.builtin.__git")

			require("telescope.builtin").git_files = function(opts)
				return git_pickers.files(set_git_root(opts))
			end

			require("telescope.builtin").git_commits = function(opts)
				return git_pickers.commits(set_git_root(opts))
			end

			require("telescope.builtin").git_bcommits = function(opts)
				return git_pickers.bcommits(set_git_root(opts))
			end

			require("telescope.builtin").git_branches = function(opts)
				return git_pickers.branches(set_git_root(opts))
			end

			require("telescope.builtin").git_status = function(opts)
				return git_pickers.status(set_git_root(opts))
			end
		end,
	},
}

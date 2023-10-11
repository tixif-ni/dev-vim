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
			{ "<leader>nt", ":NvimTreeToggle<CR>", desc = "Toggles tree display", mode = "n" },
			{ "<leader>nf", ":NvimTreeFindFile<CR>", desc = "Finds file in tree", mode = "n" },
			{ "<leader>nr", ":NvimTreeRefresh<CR>", desc = "Refreshes tree items", mode = "n" },
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
		},
		opts = {
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
			},
		},
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
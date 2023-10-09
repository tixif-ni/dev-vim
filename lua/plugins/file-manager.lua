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
			git = {
				ignore = false,
			},
			renderer = {
				indent_markers = {
					enable = true,
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
		opts = function()
			local actions = require("telescope.actions")

			return {
				defaults = {
					mappings = {
						i = {
							["<C-n>"] = false,
							["<C-p>"] = false,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
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
			}
		end,
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
			{ "<leader>fl", "<cmd>Telescope live_grep<cr>" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
			{ "<leader>fgf", "<cmd>Telescope git_files<cr>" },
			{ "<leader>fgl", "<cmd>Telescope git_local git_live_grep<cr>" },
			{ "<leader>fgw", "<cmd>Telescope git_local git_grep_string<cr>" },
			{ "<leader>fdl", "<cmd>Telescope directory_local directory_live_grep<cr>" },
			{ "<leader>fdw", "<cmd>Telescope directory_local directory_grep_string<cr>" },
			{ "<leader>fgc", "<cmd>Telescope git_commits<cr>" },
			{ "<leader>fma", "<cmd>Telescope vim_bookmarks all<cr>" },
			{ "<leader>fmf", "<cmd>Telescope vim_bookmarks current_file<cr>" },
			{ "<leader>fdf", "<cmd>Telescope lsp_document_diagnostics<cr>" },
			{ "<leader>fda", "<cmd>Telescope lsp_workspace_diagnostics<cr>" },
		},
		init = function()
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			local git_pickers = require("telescope.builtin.__git")
			local internal_pickers = require("telescope.builtin.__internal")
			local diffview = require("diffview")
			local git_utils = require("utils.git")

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("vim_bookmarks")
			require("telescope").load_extension("neoclip")

			-- LOCAL EXTENSIONS
			require("telescope").load_extension("git_local")

			require("telescope.builtin").buffers = function(opts)
				opts = opts or {}
				opts.attach_mappings = function(_, map)
					map("n", "dd", actions.delete_buffer)

					return true
				end

				return internal_pickers.buffers(opts)
			end

			require("telescope.builtin").git_files = function(opts)
				return git_pickers.files(git_utils.set_git_root(opts))
			end

			require("telescope.builtin").git_commits = function(opts)
				opts = git_utils.set_git_root(opts)

				opts.attach_mappings = function(_, map)
					map("n", "dd", function(prompt_bufnr)
						local cwd = action_state.get_current_picker(prompt_bufnr).cwd
						local selection = action_state.get_selected_entry()

						if selection ~= nil then
							diffview.open(selection.value .. "^!", "-C" .. cwd)
						end
					end)

					return true
				end

				return git_pickers.commits(opts)
			end

			require("telescope.builtin").git_bcommits = function(opts)
				return git_pickers.bcommits(git_utils.set_git_root(opts))
			end

			require("telescope.builtin").git_branches = function(opts)
				return git_pickers.branches(git_utils.set_git_root(opts))
			end

			require("telescope.builtin").git_status = function(opts)
				return git_pickers.status(git_utils.set_git_root(opts))
			end

			vim.cmd([[
              autocmd User TelescopePreviewerLoaded setlocal number
              command! -nargs=1 Livegrep lua require('telescope.builtin').live_grep({search_dirs={'<args>'}})
            ]])
		end,
	},
}

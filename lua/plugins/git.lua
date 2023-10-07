function trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function diffview_fugitive(rev)
	local diffview = require("diffview")
	local line = vim.fn.getline(".")

	local log_line = line:match("[commit|Merge:] ([a-f0-9 ]+)")
	if log_line ~= nil then
		log_line = trim(log_line)
	end

	local blame_line = line:match("([a-f0-9]+).")
	if blame_line ~= nil then
		blame_line = trim(blame_line)
	end

	if log_line ~= nil and string.len(log_line) > 7 then
		hash = log_line
	elseif blame_line ~= nil and string.len(blame_line) >= 7 then
		hash = blame_line
	else
		return
	end

	if string.find(hash, " ") then
		hash = vim.fn.substitute(hash, " ", "..", "")
	elseif rev ~= nil then
		hash = hash .. rev
	else
		hash = hash .. "^!"
	end

	local git_dir = vim.fn.substitute(vim.fn.FugitiveGitDir(), ".git", "", "")

	diffview.open(hash, "-C" .. git_dir)
end

return {
	{
		"https://github.com/tpope/vim-fugitive.git",
		dependencies = {
			"https://github.com/tommcdo/vim-fugitive-blame-ext.git",
		},
		keys = {
			{ "<leader>gf", ":!git fetch --all<CR>", desc = "Fetches all changes", mode = "n" },
			{ "<leader>gb", ":Git blame<CR>", desc = "Annotates with blame", mode = "n" },
			{ "<leader>gs", ":Git<CR>", desc = "Displays status", mode = "n" },
			{ "<leader>gc", ":Git commit<CR>", desc = "Commits changes", mode = "n" },
			{ "<leader>gr", ":Gread<CR>", desc = "Checks out", mode = "n" },
			{ "<leader>gl", ":Git log<CR>", desc = "Logs", mode = "n" },
			{ "gdh", ":diffget //2<CR>", mode = "n" },
			{ "gdl", ":diffget //3<CR>", mode = "n" },
		},
		init = function()
			vim.cmd([[
                          " Not sure what this does yet -- autocmd VimEnter * if empty(expand('<amatch>'))|call FugitiveDetect(getcwd())|endif

                          augroup git_fugitive
                            autocmd!
                            autocmd Filetype fugitive :nnoremap <buffer> <Leader>gp :Git push<CR>
                          augroup end
                        ]])
		end,
	},
	{
		"https://github.com/sodapopcan/vim-twiggy.git",
		keys = {
			{ "<leader>gt", ":Twiggy<CR>", mode = "n" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
				delete = { hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
				topdelete = {
					hl = "GitSignsDelete",
					text = "‾",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "~",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
			},
			current_line_blame_formatter_opts = {
				relative_time = false,
			},
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000,
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			yadm = {
				enable = false,
			},
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

				-- Actions
				map("n", "<leader>ghs", gs.stage_hunk)
				map("n", "<leader>ghr", gs.reset_hunk)
				map("v", "<leader>ghs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("v", "<leader>ghr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>ghS", gs.stage_buffer)
				map("n", "<leader>ghu", gs.undo_stage_hunk)
				map("n", "<leader>ghR", gs.reset_buffer)
				map("n", "<leader>ghp", gs.preview_hunk)
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end)
				map("n", "<leader>gtb", gs.toggle_current_line_blame)
				map("n", "<leader>ghd", gs.diffthis)
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end)
				map("n", "<leader>gtd", gs.toggle_deleted)

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		},
	},
	"https://github.com/rhysd/git-messenger.vim.git",
	{
		"ruanyl/vim-gh-line",
		keys = {
			{ "<leader>gy", "<Plug>(gh-line)", mode = "n" },
		},
		init = function()
			vim.g.gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '
		end,
	},
	{
		"sindrets/diffview.nvim",
		opts = {
			key_bindings = {
				view = {
					["gq"] = "<CMD>DiffviewClose<CR>",
				},
				file_panel = {
					["gq"] = "<CMD>DiffviewClose<CR>",
				},
				file_history_panel = {
					["gq"] = "<CMD>DiffviewClose<CR>",
				},
			},
		},
		keys = {
			{ "<leader>gdf", ":DiffviewFileHistory %<CR>", mode = "n" },
		},
		init = function()
			vim.cmd([[
                          augroup git_diffview
                            autocmd!
                            autocmd Filetype git :nnoremap <buffer> <Leader>dd <cmd>lua diffview_fugitive()<CR>
                            autocmd Filetype git :nnoremap <buffer> <Leader>dh <cmd>lua diffview_fugitive("..HEAD")<CR>
                            autocmd Filetype fugitiveblame :nnoremap <buffer> <Leader>dd <cmd>lua diffview_fugitive()<CR>
                          augroup end
                        ]])
		end,
	},
}

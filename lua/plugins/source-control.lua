return {
	{
		"https://github.com/tpope/vim-fugitive.git",
		dependencies = {
			"https://github.com/tommcdo/vim-fugitive-blame-ext.git",
			"sindrets/diffview.nvim",
		},
		keys = {
			{ "<leader>gf", ":!git fetch --all<CR>", desc = "Fetches all changes", mode = "n" },
			{ "<leader>gb", ":Git blame<CR>", desc = "Annotates with blame", mode = "n" },
			{ "<leader>gs", ":Git<CR>", desc = "Displays status", mode = "n" },
			{ "<leader>gc", ":Git commit<CR>", desc = "Commits changes", mode = "n" },
			{ "<leader>gr", ":Gread<CR>", desc = "Checks out", mode = "n" },
			{ "<leader>gl", ":Git log<CR>", desc = "Logs", mode = "n" },
			{ "<leader>gp", ":Git push<CR>", desc = "Pushes changes", mode = "n", ft = "fugitive" },
			{ "<leader>gP", ":Git push --force<CR>", desc = "Force pushes changes", mode = "n", ft = "fugitive" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
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
			{ "<leader>gy", "<Plug>(gh-line)", desc = "[Git] Github url", mode = "n" },
		},
		init = function()
			vim.g.gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '
		end,
	},
	{
		"sindrets/diffview.nvim",
		opts = {
			keymaps = {
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
			{ "<leader>gdf", ":DiffviewFileHistory %<CR>", mode = "n", desc = "[Git] Diff file", noremap = true },
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
		init = function()
			vim.api.nvim_create_user_command("DiffviewLine", function(opts)
				local git_utils = require("utils.git")

				-- We use fugitive here cause this is working on those fugitive
				-- specific buffers which won't allow us to get the git dir path using
				-- file finders
				local git_dir = vim.fn.substitute(vim.fn.FugitiveGitDir(), ".git", "", "")
				local hash_range = git_utils.get_line_hash_range(opts.args)

				vim.cmd(string.format("DiffviewOpen %s -C%s", hash_range, git_dir))
			end, { nargs = "?" })
		end,
	},
}

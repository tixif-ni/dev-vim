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
		},
		opts = {
			result_split_horizontal = true,
			skip_ssl_verification = true,
			result = {
				show_curl_command = false,
			},
		},
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
			vim.g.bookmark_display_annotation = 1

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

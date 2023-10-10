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
		keys = {
			{ "<localleader>rr", "<Plug>RestNvim<CR>", mode = "n", ft = "http" },
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
		init = function()
			vim.g.bookmark_save_per_working_dir = 1
			vim.g.bookmark_auto_save = 1
		end,
	},
}

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
			{
				"<localleader>rr",
				"<Plug>RestNvim<CR>",
				desc = "[Util] Execute request",
				mode = "n",
				ft = "http",
				noremap = true,
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
		init = function()
			vim.g.bookmark_save_per_working_dir = 1
			vim.g.bookmark_auto_save = 1
		end,
	},
	{
		"https://github.com/tom-anders/telescope-vim-bookmarks.nvim.git",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		commander = {
			{
				cat = "Bookmark",
				desc = "Find bookmark",
				cmd = ":Telescope vim_bookmarks all<CR>",
			},
			{
				cat = "Bookmark",
				desc = "Find file bookmark",
				cmd = ":Telescope vim_bookmarks current_file<CR>",
			},
		},
		init = function()
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
				desc = "Find container",
				cmd = ":Telescope docker<CR>",
			},
			{
				cat = "Bookmark",
				desc = "Find file bookmark",
				cmd = ":Telescope vim_bookmarks current_file<CR>",
			},
		},
		init = function()
			require("telescope").load_extension("docker")
		end,
	},
}

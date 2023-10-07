return {
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_refresh_slow = 1
		end,
	},
}

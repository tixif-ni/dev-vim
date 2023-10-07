return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = "all",
			ignore_install = { "phpdoc" },
			highlight = {
				enable = true,
			},
		},
		init = function()
			vim.opt.foldenable = false
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldminlines = 50
			vim.opt.foldnestmax = 2
		end,
	},
}

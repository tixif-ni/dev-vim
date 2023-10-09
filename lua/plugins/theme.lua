return {
	{
		"kristijanhusak/vim-hybrid-material",
		lazy = false, -- make sure we load this during startup
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.g.enable_bold_font = 1
			vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

			vim.opt.termguicolors = true
			vim.opt.background = "dark"
			vim.cmd("colorscheme hybrid_material")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {

			options = {
				theme = "material",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						file_status = true, -- displays file status (readonly status, modified status)
						path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
					},
				},
			},
			extensions = { "nvim-tree", "quickfix", "fugitive" },
		},
	},
	"https://github.com/RRethy/vim-illuminate.git",
	{
		"https://github.com/whatyouhide/vim-lengthmatters.git",
		config = function()
			vim.g.lengthmatters_start_at_column = 88
		end,
	},
	{ "sunjon/shade.nvim", opts = {} },
}

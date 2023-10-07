return {
	"kristijanhusak/vim-hybrid-material",
	{
		"hoob3rt/lualine.nvim",
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
	{
		"https://github.com/RRethy/vim-illuminate.git",
		init = function()
			vim.cmd([[
                hi illuminatedWord cterm=underline gui=underline 
            ]])
		end,
	},
	{
		"https://github.com/whatyouhide/vim-lengthmatters.git",
		init = function()
			vim.g.lengthmatters_start_at_column = 88
		end,
	},
	{
		"https://github.com/blueyed/vim-diminactive.git",
		init = function()
			vim.g.diminactive_enable_focus = 1
		end,
	},
}

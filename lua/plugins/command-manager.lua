local utils = require("utils.git")

return {
	{
		"FeiyouG/commander.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = function()
			return {
				integration = {
					lazy = {
						enable = true,
					},
					telescope = {
						enable = true,
						theme = require("telescope.themes").commander,
					},
				},
			}
		end,
		keys = {
			{ "<leader>fc", ":Telescope commander<CR>", mode = "n" },
		},
		init = function()
			require("telescope").load_extension("commander")
		end,
	},
}

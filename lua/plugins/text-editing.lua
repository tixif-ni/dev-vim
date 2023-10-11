return {
	"https://github.com/tpope/vim-surround.git",
	"mg979/vim-visual-multi",
	"https://github.com/Raimondi/delimitMate.git",
	{
		"https://github.com/andymass/vim-matchup.git",
		init = function()
			vim.g.matchup_matchparen_deferred = 1
		end,
	},
	{
		"https://github.com/AckslD/nvim-neoclip.lua.git",
		opts = {
			history = 100,
			keys = {
				telescope = {
					i = {
						select = "<CR>",
						paste = "<C-p>",
						paste_behind = "<C-P>",
					},
					n = {
						select = "<CR>",
						paste = "p",
						paste_behind = "P",
					},
				},
			},
		},
	},
	{
		"dhruvasagar/vim-table-mode",
		init = function()
			vim.g.table_mode_corner = "|"
		end,
	},
	{
		-- TODO: Maybe... needs more testing/configs
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
	},
}

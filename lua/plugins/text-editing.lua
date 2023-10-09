return {
	{
		"https://github.com/Lokaltog/vim-easymotion.git",
		init = function()
			vim.cmd([[
              :map / <Plug>(easymotion-sn)
              :omap / <Plug>(easymotion-tn)
            ]])
		end,
	},
	"https://github.com/tpope/vim-surround.git",
	"https://github.com/tpope/vim-unimpaired.git",
	"https://github.com/terryma/vim-multiple-cursors.git",
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
}

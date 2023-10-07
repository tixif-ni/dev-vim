-- EASYMOTION
vim.cmd([[
  :map / <Plug>(easymotion-sn)
  :omap / <Plug>(easymotion-tn)
]])

-- MATCHUP
vim.cmd([[
  let g:matchup_matchparen_deferred = 1
]])

-- COMMENTS
vim.cmd([[
  command! TodoCurrent execute 'TodoQuickFix cwd='.expand("%:p")
]])

require("todo-comments").setup({
	keywords = {
		FIX = {
			icon = " ",
			color = "error",
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
		},
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
	},
})

-- BOOKMARKS
vim.cmd([[
  let g:bookmark_save_per_working_dir = 1
  let g:bookmark_auto_save = 1
]])

-- NEOCLIP
require("neoclip").setup({
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
})

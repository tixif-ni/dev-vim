-- LUALINE
require('lualine').setup {
  options = {
    theme = 'material'
  },
  sections = {
  lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    }
  },
  extensions = { 'nvim-tree', 'quickfix', 'fugitive' }
}

-- DIMINACTIVE
vim.cmd([[
  let g:diminactive_enable_focus = 1
]])

-- ILLUMINATE
vim.cmd([[
  hi illuminatedWord cterm=underline gui=underline 
]])


-- LENGTHMATTERS
vim.cmd([[
  let g:lengthmatters_start_at_column = 88
]])

-- EASYMOTION
vim.cmd([[
  :map / <Plug>(easymotion-sn)
  :omap / <Plug>(easymotion-tn)
]])

-- MATCHUP
vim.cmd([[
  let g:matchup_matchparen_deferred = 1
]])

-- REST
vim.cmd([[
  nmap <leader>rr <Plug>RestNvim
  nmap <leader>rp <Plug>RestNvimPreview
]])

require"rest-nvim".setup {
  result_split_horizontal = true,
  skip_ssl_verification = true,
}

-- MARKDOWNPREVIEW
vim.cmd([[
  let g:mkdp_auto_close = 1
  let g:mkdp_refresh_slow = 1
]])

-- COMMENTS
vim.cmd([[
  command! TodoCurrent execute 'TodoQuickFix cwd='.expand("%:p")
]])

require("todo-comments").setup {
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
}

-- BOOKMARKS
vim.cmd([[
  let g:bookmark_save_per_working_dir = 1
  let g:bookmark_auto_save = 1
]])

-- NEOCLIP
require'neoclip'.setup{
  history = 100,
  keys = {
    telescope = {
      i = {
        select = '<CR>',
        paste = '<C-p>',
        paste_behind = '<C-P>',
      },
      n = {
        select = '<CR>',
        paste = 'p',
        paste_behind = 'P',
      },
    }
  },
}

-- CHEATSHEET
require'cheatsheet'.setup{
  bundled_cheatsheets = false,
  bundled_plugin_cheatsheets = false
}

-- TABLEMODE
-- MD compatibility
vim.cmd([[
  let g:table_mode_corner='|'
]])

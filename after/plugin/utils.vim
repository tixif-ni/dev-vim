"=============================================================================
" EASYMOTION
"=============================================================================

:map / <Plug>(easymotion-sn)
:omap / <Plug>(easymotion-tn)

"=============================================================================
" MATCHUP
"=============================================================================

let g:matchup_matchparen_deferred = 1

"=============================================================================
" REST
"=============================================================================

nmap <leader>rr <Plug>RestNvim
nmap <leader>rp <Plug>RestNvimPreview

lua << EOF
require"rest-nvim".setup {
  result_split_horizontal = true,
  skip_ssl_verification = true,
}
EOF

"=============================================================================
" MARKDOWNPREVIEW
"=============================================================================

let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 1

"=============================================================================
" COMMENTS
"=============================================================================

command! TodoCurrent execute 'TodoQuickFix cwd='.expand("%:p")
lua << EOF
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
EOF

"=============================================================================
" BOOKMARKS
"=============================================================================

let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

"=============================================================================
" NEOCLIP
"=============================================================================

lua << EOF
require'neoclip'.setup{
  history = 100,
  keys = {
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
  },
}
EOF

"=============================================================================
" CHEATSHEET
"=============================================================================

lua << EOF
require'cheatsheet'.setup{
  bundled_cheatsheets = false,
  bundled_plugin_cheatsheets = false
}
EOF

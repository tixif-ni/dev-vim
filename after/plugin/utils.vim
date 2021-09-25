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
" GLOW
"=============================================================================

let g:glow_binary_path = "/usr/local/bin"

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

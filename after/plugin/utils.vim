"=============================================================================
" EASYMOTION
"=============================================================================

:map / <Plug>(easymotion-sn)
:omap / <Plug>(easymotion-tn)

"=============================================================================
" MATCHUP
"=============================================================================

:hi MatchParen ctermbg=blue guibg=lightblue cterm=italic gui=italic
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

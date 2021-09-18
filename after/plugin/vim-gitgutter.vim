"nmap <leader>gj <plug>(signify-next-hunk)
"nmap <leader>gk <plug>(signify-prev-hunk)
":nnoremap <Leader>gh :SignifyHunkDiff<CR>
"
command! Gqf GitGutterQuickFix | copen
nmap <leader>ghj <Plug>(GitGutterNextHunk)
nmap <leader>ghk <Plug>(GitGutterPrevHunk)
nmap <leader>ghs <Plug>(GitGutterStageHunk)
nmap <leader>ghu <Plug>(GitGutterUndoHunk)
nmap <leader>ghp <Plug>(GitGutterPreviewHunk)

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff0000 ctermfg=1

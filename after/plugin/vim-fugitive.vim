autocmd VimEnter * if empty(expand('<amatch>'))|call FugitiveDetect(getcwd())|endif
:nnoremap <Leader>gf :!git fetch --all<CR>
:nnoremap <Leader>gb :Git blame<CR>
:nnoremap <Leader>gs :Git<CR>
:nnoremap <Leader>gd :Gvdiffsplit!<CR>
:nnoremap <Leader>gc :Git commit<CR>
:nnoremap <Leader>gp :Git push<CR>
:nnoremap <Leader>gr :Gread<CR>
:nnoremap gdh :diffget //2<CR>
:nnoremap gdl :diffget //3<CR>

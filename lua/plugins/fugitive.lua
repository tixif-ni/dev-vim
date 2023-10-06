vim.cmd([[
  autocmd VimEnter * if empty(expand('<amatch>'))|call FugitiveDetect(getcwd())|endif
  :nnoremap <Leader>gf :!git fetch --all<CR>
  :nnoremap <Leader>gb :Git blame<CR>
  :nnoremap <Leader>gs :Git<CR>
  :nnoremap <Leader>gc :Git commit<CR>
  :nnoremap <Leader>gr :Gread<CR>
  :nnoremap <Leader>gl :Git log<CR>
  :nnoremap gdh :diffget //2<CR>
  :nnoremap gdl :diffget //3<CR>

  augroup git_fugitive
    autocmd!
    autocmd Filetype fugitive :nnoremap <buffer> <Leader>gp :Git push<CR>
  augroup end
]])

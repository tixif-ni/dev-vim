" Pytest
:nnoremap <localleader>tm :Pytest method<CR>
:nnoremap <localleader>tmd :Pytest method --pdb<CR>
:nnoremap <localleader>tf :Pytest file<CR>
:nnoremap <localleader>tc :Pytest class<CR>
:nnoremap <localleader>tp :Pytest project<CR>
:nnoremap <localleader>ts :Pytest session<CR>

" function name
:onoremap fn :<c-u>execute "normal! ?def\\s\r:nohlsearch\rwviw"<cr>
" class name
:onoremap cn :<c-u>execute "normal! ?class\\s\r:nohlsearch\rwviw"<cr>


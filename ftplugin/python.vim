" Pytest
:nnoremap <buffer> <localleader>tm :Pytest method<CR>
:nnoremap <buffer> <localleader>tmd :Pytest method -s<CR>
:nnoremap <buffer> <localleader>ta :Pytest file<CR>
:nnoremap <buffer> <localleader>tf :Pytest function -v<CR>
:nnoremap <buffer> <localleader>tfd :Pytest function -s<CR>
:nnoremap <buffer> <localleader>tc :Pytest class<CR>
:nnoremap <buffer> <localleader>tp :Pytest project<CR>
:nnoremap <buffer> <localleader>ts :Pytest session<CR>

" function name
:onoremap <buffer> fn :<c-u>execute "normal! ?def\\s\r:nohlsearch\rwviw"<cr>
" class name
:onoremap <buffer> cn :<c-u>execute "normal! ?class\\s\r:nohlsearch\rwviw"<cr>

" run file
:nnoremap <buffer> <localleader>r :ter python "%"<CR>

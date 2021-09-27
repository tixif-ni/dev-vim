"=============================================================================
" AIRLINE
"=============================================================================

let g:airline_theme = "molokai"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" required for airline so it shows on normal buffers
set laststatus=2
set ttimeoutlen=50

"=============================================================================
" DIMINACTIVE
"=============================================================================

let g:diminactive_enable_focus = 1

"=============================================================================
" ILLUMINATE
"=============================================================================

hi illuminatedWord cterm=underline gui=underline 

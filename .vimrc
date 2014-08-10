:"Pathogen plugin in order to handle the installation of every other plugin
execute pathogen#infect()
execute pathogen#helptags()

:set encoding=utf-8
:set wildmenu
:set guioptions-=m
:set guioptions-=T
:set smartcase
:set ignorecase
:set number
:set more
:set cursorline

"Stop vim's crazy formatting when pasting with the mouse
:set pastetoggle=<F5>

"Open all folds on load - fixes fugitive exiting diff mode
:set foldlevel=20

"Faster character redrawing
:set ttyfast

"Reload file if modified
:set autoread

"Highlight search as you type
:set hlsearch
:set incsearch

:set expandtab
:set tabstop=2 shiftwidth=2 softtabstop=2
:set autoindent
:set smartindent
:set showmatch

"Allow to switch buffers without having to save its changes
:set hidden

"Do not create backup files
:set nobackup
:set noswapfile

"I like to see hidden spaces, tabs, etc
:set listchars=eol:$,tab:>-,trail:-

syntax on
filetype on
filetype indent on
filetype plugin on

"Disable annoying beep sound when errors ocurr, it just clears the value to empty
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Maximize window on start
if has("gui_running")
" GUI is running or is about to start.
" Maximize gvim windows.
set lines=999 columns=999
endif

" Colorscheme 
if has("gui_running")
:set background=dark
:set t_Co=16
:colorscheme solarized
else
:set t_Co=256
:colorscheme hybrid
endif

"Let's try not to exceed 80 char columns
"with a lighter background warning
if exists('+colorcolumn')
 let &colorcolumn="80,".join(range(80, 320),",")
endif

" REMAPS
"Leader
:let mapleader=","

" toogle invisibles
:nmap <Leader>l :set list!<CR>
:vmap <Leader>l :set list!<CR>

" moved up|down in wrapped lines
:nmap j gj
:nmap k gk

" nerdtree
nmap <F9> :NERDTreeToggle<CR>
" tagbar
nmap <F10> :TagbarToggle<CR>

" fugitive
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gp :Git push<CR>

" vim-git-log
nnoremap <Leader>gl :GitLog<CR>

" zoomwin
noremap <Leader>zw :ZoomWin<CR>

" buffergator
nmap <Leader>b :BuffergatorToggle<CR>

" Move around buffers
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Make current buffer only buffer in split modes
map <Leader>o <C-w><C-o>
" Undo buffer
map <Leader>q <C-w>q
" Close buffer without losing splits
nnoremap <C-c> :bp\|bd #<CR>
" Break line without 
nmap <Leader><CR> i<CR><Esc>

" Tabularize
nnoremap <Leader>t :Tabularize /
vnoremap <Leader>t :Tabularize /

"Not working, review when possible...
"Yank/paste to the OS clipboard
"nnoremap <leader>y "+y
"nnoremap <leader>Y "+yy
"nnoremap <leader>p "+p
"nnoremap <leader>P "+P

" : => ;
nnoremap ; :
vnoremap ; :

"Sudo into file to make changes
cmap w!! w !sudo tee % >/dev/null

" PLUGINS

" syntastic
let g:syntastic_enable_highlighting=0
let g:syntastic_javascript_checkers=['jshint']
"" Do not trigger with sass files types
let g:syntastic_mode_map = { 'passive_filetypes': ['scss'] }
"" Do not trigger checks if buffer is closed
let g:syntastic_check_on_wq=0

" Nerdtree
let g:NERDTreeDirArrows = 0
let NERDTreeIgnore=['\.pyc$']

" ctrlP
let g:ctrlp_custom_ignore= {
      \'dir': '\v[\/](node_modules|bower_components)$',
      \'file': '\vtags|\v\.(pyc)'
      \}

" airline bar
let g:airline_theme='molokai'
let g:airline#extensions#virtualenv#enabled=1
"" required for airline so it shows on normal buffers
set laststatus=2
set ttimeoutlen=50

" buffergator
let g:buffergator_suppress_keymaps=1

" supertab
let g:SuperTabDefaultCompletionType="context"

" snipmate
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['scss'] = 'css'
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

" easymotion
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" easytags
let g:easytags_async=1
let g:easytags_syntax_keyword = 'always'
let g:easytags_file = './tags'

" Functions

" Generate ctags for current folder
map <f12> :call UpdateTags()<cr>

"" Set correct tag_paths if working with virtualenv
function! SetTagPath()
  let tag_paths = './tags;'
  if has('python') && isdirectory($VIRTUAL_ENV)
     let tag_paths = tag_paths.",".$VIRTUAL_ENV."/tags"
  endif
  :let &tags=tag_paths
endfunction
"" Call function just when loading
:call SetTagPath()

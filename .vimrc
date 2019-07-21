" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'https://github.com/mattn/emmet-vim.git'
Plug 'https://github.com/tmhedberg/matchit.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/tpope/vim-pathogen.git'
Plug 'https://github.com/bling/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/Lokaltog/vim-easymotion.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/jelera/vim-javascript-syntax.git'
Plug 'https://github.com/groenewege/vim-less.git'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/mhinz/vim-signify.git'
Plug 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
Plug 'https://github.com/tomtom/tlib_vim.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/alfredodeza/pytest.vim.git'
Plug 'https://github.com/mileszs/ack.vim.git'
Plug 'https://github.com/Shougo/neocomplcache.vim.git'
Plug 'https://github.com/aquach/vim-http-client.git'
Plug 'https://github.com/chrisbra/NrrwRgn.git'
Plug 'https://github.com/mattn/webapi-vim.git'
Plug 'https://github.com/leafgarland/typescript-vim.git'
Plug 'https://github.com/Shougo/vimproc.vim.git', {'do': 'make'}
Plug 'https://github.com/junegunn/gv.vim.git'
Plug 'https://github.com/dhruvasagar/vim-table-mode'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/whatyouhide/vim-lengthmatters.git'
Plug 'https://github.com/AndrewRadev/splitjoin.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'https://github.com/neoclide/coc.nvim.git', {'branch': 'release'}
Plug 'https://github.com/Shougo/neosnippet.vim.git'

" Initialize plugin system
call plug#end()

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

"Faster character redrawing
:set ttyfast

"Reload file if modified
:set autoread

"Highlight search as you type
:set hlsearch
:set incsearch

:set expandtab
:set tabstop=4 shiftwidth=4 softtabstop=4
:set autoindent
:set smartindent
:set showmatch

"Allow to switch buffers without having to save its changes
:set hidden

"Do not create backup files
:set nobackup
:set noswapfile
:set nowritebackup

"I like to see hidden spaces, tabs, etc
:set listchars=eol:$,tab:>-,trail:-

" Hide preview when auto completing
:set completeopt-=preview

syntax on
filetype on
filetype indent on
filetype plugin on

"Disable annoying beep sound when errors ocurr, it just clears the value to empty
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Colorscheme 
:set t_Co=256
:set termguicolors
:set background=dark
:colorscheme hybrid_material
:let g:airline_theme = "hybrid"

" ABBREVIATIONS
" make sure to fill these in as they come
:iabbrev waht what
:iabbrev tehn then

" REMAPS
" Leader
:let mapleader=","
:let maplocalleader = "\\"
:imap jj <Esc>

" Disable arrows like a mofo
:inoremap <Up> <nop>
:inoremap <Down> <nop>
:inoremap <Left> <nop>
:inoremap <Right> <nop>
:nnoremap <Up> <nop>
:nnoremap <Down> <nop>
:nnoremap <Left> <nop>
:nnoremap <Right> <nop>

" Edit vimrc
:nnoremap <leader>ev :sp $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" select word where cursor is
:nnoremap <space> viw
" toggle case
:inoremap <Leader>t <esc>viw~ea

" moved up|down in wrapped lines
:nnoremap j gj
:nnoremap k gk

" nerdtree
:nnoremap <Leader>nt :NERDTreeToggle<CR>
:nnoremap <Leader>nb :Bookmark
:nnoremap <Leader>nob :OpenBookmark

" tagbar, Open source code tree
:nnoremap <Leader>sc :TagbarToggle<CR>

" fugitive
:nnoremap <Leader>gb :Gblame<CR>
:nnoremap <Leader>gs :Gstatus<CR>
:nnoremap <Leader>gd :Gdiff<CR>
:nnoremap <Leader>gc :Gcommit<CR>
:nnoremap <Leader>gp :Git push<CR>
:nnoremap <Leader>gh :GV<CR>

" Move around buffers
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>
:nnoremap <C-X> :bdelete<CR>
:nnoremap <Leader>b :CtrlPBuffer<CR>

" Make current buffer only buffer in split modes
:nnoremap <Leader>o <C-w><C-o>
" Undo buffer
:nnoremap <Leader>q <C-w>q
" Close buffer without losing splits
:nnoremap <C-c> :bp\|bd #<CR>
" Break line without 
:nnoremap <Leader><CR> i<CR><Esc>
:nnoremap <Leader><Bar> :vert sp<CR>
:nnoremap <Leader>- :sp<CR>

" Ack
:nnoremap <Leader>ak :execute ":Ack! ". shellescape("<cword>")<CR>

" : => ;
:nnoremap ; :
:vnoremap ; :

"Sudo into file to make changes
:cnoremap w!! w !sudo tee % >/dev/null

" Buffer resizing
map <Leader>j :5winc +<CR>
map <Leader>k :5winc -<CR>
map <Leader>l :5winc <<CR>
map <Leader>h :5winc ><CR>

" PLUGINS

" Coc
:let g:coc_global_extensions=[
            \'coc-marketplace',
            \'coc-neosnippet',
            \'coc-python',
            \'coc-tsserver',
            \'coc-html',
            \'coc-highlight',
            \'coc-omnisharp']

autocmd CursorHold * silent call CocActionAsync('highlight')


let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Nerdtree
let g:NERDTreeDirArrows = 0
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']

" neocomplete
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list = 10
let g:neocomplcache_auto_completion_start_length = 3
" Like g:neocomplcache_snippets_disable_runtime_snippets
" behavior(all runtime snippets are disabled).
let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
let g:neocomplcache_temporary_dir = "$HOME/.vim/tmp/neocomplcache"

" neosnippets
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets'
imap <c-j> <Plug>(neosnippet_expand_or_jump)
smap <c-j> <Plug>(neosnippet_expand_or_jump)
xmap <c-j> <Plug>(neosnippet_expand_target)

" Use Tab for completion
:inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>""

" ctrlP
let g:ctrlp_custom_ignore= {
      \'dir': '\v[\/](node_modules|bower_components)$',
      \'file': '\vtags|\v\.(pyc)'
      \}

" airline bar
let g:airline_theme='molokai'
"" required for airline so it shows on normal buffers
set laststatus=2
set ttimeoutlen=50

" easymotion
:map / <Plug>(easymotion-sn)
:omap / <Plug>(easymotion-tn)

" vim-http-client
let g:http_client_bind_hotkey = 0
silent! nnoremap <unique> <Leader>hc :HTTPClientDoRequest<cr>

" vim-illuminate
let g:Illuminate_delay = 300
let g:Illuminate_ftblacklist = ['nerdtree', 'ctrlp']
hi illuminatedWord cterm=underline gui=underline

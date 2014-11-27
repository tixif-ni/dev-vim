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
:set nowritebackup

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
    au GUIEnter * simalt ~x
else
    :set t_Co=256
endif

" Colorscheme 
if has("win32") || has("win64")
    " Set solarized theme in windows so it matches conemu's pallete
    :set background=dark
    :colorscheme solarized
    let g:solarized_termcolors=256
else
    :colorscheme hybrid
end

"Let's try not to exceed 80 char columns
"with a lighter background warning
if exists('+colorcolumn')
 let &colorcolumn="80,".join(range(80, 320),",")
endif

" ABBREVIATIONS
" make sure to fill these in as they come
:iabbrev waht what
:iabbrev tehn then

" REMAPS
" Leader
:let mapleader=","
:let maplocalleader = "\\"

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
:inoremap <c-u> <esc>viw~ea

" OPERATOR-PENDING mappings
:onoremap p i(
:onoremap b i{
:onoremap s i[

" toogle invisibles
":nnoremap <Leader>l :set list!<CR>
":vnoremap <Leader>l :set list!<CR>

" moved up|down in wrapped lines
:nnoremap j gj
:nnoremap k gk

" nerdtree
:nnoremap <F9> :NERDTreeToggle<CR>
" tagbar
:nnoremap <F10> :TagbarToggle<CR>

" fugitive
:nnoremap <Leader>gb :Gblame<CR>
:nnoremap <Leader>gs :Gstatus<CR>
:nnoremap <Leader>gd :Gdiff<CR>
:nnoremap <Leader>gc :Gcommit<CR>
:nnoremap <Leader>gp :Git push<CR>

" vim-git-log
:nnoremap <Leader>gl :GitLog<CR>

" buffergator
:nnoremap <Leader>b :BuffergatorToggle<CR>

" Move around buffers
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l

" Make current buffer only buffer in split modes
:nnoremap <Leader>o <C-w><C-o>
" Undo buffer
:nnoremap <Leader>q <C-w>q
" Close buffer without losing splits
:nnoremap <C-c> :bp\|bd #<CR>
" Break line without 
:nnoremap <Leader><CR> i<CR><Esc>

" Tabularize
:nnoremap <Leader>t :Tabularize /
:vnoremap <Leader>t :Tabularize /

" Ack
:nnoremap <Leader>g :execute ":Ack! ". shellescape("<cword>")<CR>

if has("python")
  " let python figure out the path to pydoc
  python << EOF
import sys
import vim
vim.command("let s:pydoc_path=\'" + sys.prefix + "/lib/pydoc.py\'")
EOF
else
  " manually set the path to pydoc
  let s:pydoc_path = "/path/to/python/lib/pydoc.py"
endif

:nnoremap <buffer> K :<C-u>let save_isk = &iskeyword \|
    \ set iskeyword+=. \|
    \ execute "Pyhelp " . expand("<cword>") \|
    \ let &iskeyword = save_isk<CR>
command! -nargs=1 -bar Pyhelp :call ShowPydoc(<f-args>)
function! ShowPydoc(what)
  let bufname = a:what . ".pydoc"
  " check if the buffer exists already
  if bufexists(bufname)
    let winnr = bufwinnr(bufname)
    if winnr != -1
      " if the buffer is already displayed, switch to that window
      execute winnr "wincmd w"
    else
      " otherwise, open the buffer in a split
      execute "sbuffer" bufname
    endif
  else
    " create a new buffer, set the nofile buftype and don't display it in the
    " buffer list
    execute "split" fnameescape(bufname)
    setlocal buftype=nofile
    setlocal nobuflisted
    " read the output from pydoc
    execute "r !" . shellescape(s:pydoc_path, 1) . " " . shellescape(a:what, 1)
  endif
  " go to the first line of the document
  1
endfunction

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

" Map tab to % for easier navigation between ({[
:nnoremap <Tab> %

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
let NERDTreeIgnore=['\.pyc$', 'tags']

" neocomplete
let g:neocomplcache_enable_at_startup = 1

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

" snipmate
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['scss'] = 'css'
:imap <C-J> <Plug>snipMateNextOrTrigger
:smap <C-J> <Plug>snipMateNextOrTrigger

" easymotion
:map / <Plug>(easymotion-sn)
:omap / <Plug>(easymotion-tn)

" Functions

" CTags related functions
function! IsInPython()
  return has('python') && isdirectory($VIRTUAL_ENV)
endfunction

"" Set correct tag_paths if working with virtualenv
function! SetTagPath()
  let tag_paths = './tags;'
  if IsInPython()
     let tag_paths = tag_paths.",".$VIRTUAL_ENV."/tags"
  endif
  :let &tags=tag_paths
endfunction
"" Call function just when loading
:call SetTagPath()

function! UpsertTags()
  let tag_command = 'ctags -R -f'
  if IsInPython()
    let ts_tags = getftime($VIRTUAL_ENV.'/tags')
    let ts_requirements = getftime('requirements.txt')
    if ts_requirements > 0 && (ts_tags == -1 || ts_requirements > ts_tags)
      let tag_command =tag_command.' && cd '.$VIRTUAL_ENV.' && '.tag_command
    endif
  endif
  execute ":! ".tag_command
endfunction

map <f12> :call UpsertTags()<CR>

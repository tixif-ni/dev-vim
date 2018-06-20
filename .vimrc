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

" Maximize window on start
if has("gui_running")
    au GUIEnter * simalt ~x
else
    :set t_Co=256
endif

" Colorscheme 
if (has("win32") || has("win64")) && !has("gui_running")
    " Set solarized theme in windows so it matches conemu's pallete
    :set background=dark
    :colorscheme solarized
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
" toggle case
:inoremap <Leader>t <esc>viw~ea

" OPERATOR-PENDING mappings
":onoremap p i(
":onoremap b i{
":onoremap s i[

" toogle invisibles
":nnoremap <Leader>l :set list!<CR>
":vnoremap <Leader>l :set list!<CR>

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

" Ack
:nnoremap <Leader>ak :execute ":Ack! ". shellescape("<cword>")<CR>

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

" PLUGINS
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 1
let g:ale_fixers = {
\   'html': ['htmlhint'],
\   'sass': ['sass-lint'],
\   'css': ['prettier'],
\   'less': ['prettier'],
\   'json': ['prettier'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'python': ['flake8', 'autopep8'],
\}

" Nerdtree
let g:NERDTreeDirArrows = 0
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$', 'tags']

" neocomplete
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list = 10
let g:neocomplcache_auto_completion_start_length = 3
" Like g:neocomplcache_snippets_disable_runtime_snippets
" behavior(all runtime snippets are disabled).
let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
" use Tab for completion
:inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" neosnippets
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets'
imap <c-j> <Plug>(neosnippet_expand_or_jump)
smap <c-j> <Plug>(neosnippet_expand_or_jump)
xmap <c-j> <Plug>(neosnippet_expand_target)

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
let g:airline#extensions#virtualenv#enabled=1
"" required for airline so it shows on normal buffers
set laststatus=2
set ttimeoutlen=50

" buffergator
let g:buffergator_suppress_keymaps=1

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

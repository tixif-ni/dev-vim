" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'https://github.com/mattn/emmet-vim.git'
Plug 'https://github.com/tmhedberg/matchit.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
Plug 'https://github.com/bling/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/Lokaltog/vim-easymotion.git'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/mhinz/vim-signify.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/sodapopcan/vim-twiggy.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/alfredodeza/pytest.vim.git'
Plug 'https://github.com/mileszs/ack.vim.git'
Plug 'https://github.com/chrisbra/NrrwRgn.git'
Plug 'https://github.com/junegunn/gv.vim.git'
Plug 'https://github.com/dhruvasagar/vim-table-mode'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/whatyouhide/vim-lengthmatters.git'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'https://github.com/reisub0/hot-reload.vim.git'
Plug 'https://github.com/neoclide/coc.nvim.git', {'branch': 'release'}
Plug 'https://github.com/sheerun/vim-polyglot.git'
Plug 'https://github.com/ryanoasis/vim-devicons.git'
Plug 'https://github.com/rhysd/git-messenger.vim.git'
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/honza/vim-snippets.git'
Plug 'https://github.com/RRethy/vim-illuminate.git'
Plug 'https://github.com/jbgutierrez/vim-better-comments.git'
Plug 'https://github.com/andymass/vim-matchup.git'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
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

" Performance boosters
:set nocursorline
:set lazyredraw
:set noshowcmd
:set synmaxcol=120
:set ttyfast
:syntax sync minlines=64

"Stop vim's crazy formatting when pasting with the mouse
:set pastetoggle=<F5>

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
:set background=dark
:colorscheme hybrid_reverse

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

" toggle case
:inoremap <Leader>t <esc>viw~ea

" moved up|down in wrapped lines
:nnoremap j gj
:nnoremap k gk

" nerdtree
:nnoremap <Leader>nt :NERDTreeToggle<CR>
:let g:NERDTreeDirArrowExpandable = '→'
:let g:NERDTreeDirArrowCollapsible = '↓'

" tagbar, Open source code tree
:nnoremap <Leader>sc :TagbarToggle<CR>

:nnoremap <C-X> :bdelete<CR>
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

" Misc
" copy current files path to clipboard
nmap cp :let @+ = expand("%") <cr>"
noremap H ^
noremap L g_

" PLUGINS

" ============================================================================
" Coc
" ============================================================================
:let g:coc_filetype_map = {
    \'yaml.ansible': 'yaml',
    \ }
:let g:coc_global_extensions=[
            \'coc-diagnostic',
            \'coc-marketplace',
            \'coc-tabnine',
            \'coc-snippets',
            \'coc-yaml',
            \'coc-post',
            \'coc-prettier',
            \'coc-docker',
            \'coc-python',
            \'coc-tsserver',
            \'coc-tslint-plugin',
            \'coc-eslint',
            \'coc-json',
            \'coc-html',
            \'coc-css',
            \'coc-omnisharp']

set shortmess+=c
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" UltiSnips Snippets integration
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" ============================================================================
" ULTISNIPS
" ============================================================================
let g:UltiSnipsExpandTrigger = '<C-j>'

" ============================================================================
" HYBRID
" ============================================================================
let g:enable_bold_font = 1
let g:enable_italic_font = 1

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

" ============================================================================
" AIRLINE
" ============================================================================
let g:airline_theme = "hybrid"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" ============================================================================
" AIRLINEBAR
" ============================================================================
let g:airline_theme='molokai'
"" required for airline so it shows on normal buffers
set laststatus=2
set ttimeoutlen=50

" ============================================================================
" NERDTREE
" ============================================================================
let g:NERDTreeDirArrows = 0
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']

" ============================================================================
" CTRLP
" ============================================================================
:nnoremap <Leader>b :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore= {
      \'dir': '\v[\/](node_modules|bower_components)$',
      \'file': '\vtags|\v\.(pyc)'
      \}

" ============================================================================
" EASYMOTION
" ============================================================================
:map / <Plug>(easymotion-sn)
:omap / <Plug>(easymotion-tn)

" ============================================================================
" Git
" ============================================================================
autocmd VimEnter * if empty(expand('<amatch>'))|call FugitiveDetect(getcwd())|endif
:nnoremap <Leader>gb :Gblame<CR>
:nnoremap <Leader>gs :Git<CR>
:nnoremap <Leader>gd :Gdiff<CR>
:nnoremap <Leader>gc :Gcommit<CR>
:nnoremap <Leader>gp :Git push<CR>
:nnoremap <Leader>gl :GV<CR>
:nnoremap <Leader>gr :Gread<CR>
:nnoremap <Leader>gt :Twiggy<CR>

" ============================================================================
" SIGNIFY
" ============================================================================
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
:nnoremap <Leader>gh :SignifyHunkDiff<CR>

" ============================================================================
" ILLUMINATE
" ============================================================================
hi illuminatedWord cterm=underline gui=underline 

" ============================================================================
" BETTER COMMENTS 
" ============================================================================
hi def link ErrorBetterComments ErrorMsg 
hi def link HighlightBetterComments CocUnderline 
hi def link QuestionBetterComments CursorLineNr 
hi def link StrikeoutBetterComments CocInfoSign 
hi def link TodoBetterComments Todo

" ============================================================================
" MATCHUP
" ============================================================================
:hi MatchParen ctermbg=blue guibg=lightblue cterm=italic gui=italic
let g:matchup_matchparen_deferred = 1

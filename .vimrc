" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Git
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/sodapopcan/vim-twiggy.git'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/junegunn/gv.vim.git'
Plug 'https://github.com/rhysd/git-messenger.vim.git'
Plug 'https://github.com/ruanyl/vim-gh-line'

" Tmux
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/tmux-plugins/vim-tmux-focus-events'

" Theme
Plug 'https://github.com/kristijanhusak/vim-hybrid-material'
Plug 'https://github.com/bling/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/RRethy/vim-illuminate.git'
Plug 'https://github.com/whatyouhide/vim-lengthmatters.git'
Plug 'https://github.com/blueyed/vim-diminactive.git'

" Language
Plug 'https://github.com/mattn/emmet-vim.git'
Plug 'https://github.com/alfredodeza/pytest.vim.git'

" Misc
Plug 'https://github.com/Lokaltog/vim-easymotion.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/jbgutierrez/vim-better-comments.git'
Plug 'https://github.com/andymass/vim-matchup.git'

Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-telescope/telescope.nvim'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


Plug 'https://github.com/kyazdani42/nvim-web-devicons'
Plug 'https://github.com/kyazdani42/nvim-tree.lua'

"Plug 'https://github.com/mileszs/ack.vim.git'
"Plug 'https://github.com/reisub0/hot-reload.vim.git'
"Plug 'https://github.com/neoclide/coc.nvim.git', {'branch': 'release'}
"Plug 'https://github.com/sheerun/vim-polyglot.git'
"Plug 'https://github.com/SirVer/ultisnips.git'
"Plug 'https://github.com/honza/vim-snippets.git'
"Plug 'OmniSharp/omnisharp-vim'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
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
:set re=1
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

"Indents
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
:colorscheme hybrid_material

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

" Edit common files
:nnoremap <leader>ev :sp $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
:nnoremap <leader>ep :sp <C-R>=expand($VIRTUAL_ENV)."/bin/postactivate"<CR><CR>

" toggle case
:noremap <Leader>tl <esc>viwu
:noremap <Leader>tu <esc>viwU

" move up|down in wrapped lines
:nnoremap j gj
:nnoremap k gk

:nnoremap <C-X> :bd!<CR>
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

" : => ;
:nnoremap ; :
:vnoremap ; :

"Sudo into file to make changes
:cnoremap w!! w !sudo tee % >/dev/null

" Buffer resizing
map <Leader>j :10winc +<CR>
map <Leader>k :10winc -<CR>
map <Leader>l :10winc <<CR>
map <Leader>h :10winc ><CR>

" Copy current file path to clipboard using xclip
set clipboard=unnamedplus
nmap cp :let @+ = expand('%').':'.line('.')<CR>

" Misc
noremap H ^
noremap L g_

" PLUGINS
" ============================================================================
" Ack
" ============================================================================
"let g:ackprg = 'ag --nogroup --nocolor --column'
":nnoremap <Leader>ak :execute ":Ack! ". shellescape("<cword>")<CR>


" ============================================================================
" Coc
" ============================================================================
":let g:coc_filetype_map = {
    "\'yaml.ansible': 'yaml',
    "\ }
":let g:coc_global_extensions=[
            "\'coc-diagnostic',
            "\'coc-marketplace',
            "\'coc-tabnine',
            "\'coc-snippets',
            "\'coc-yaml',
            "\'coc-post',
            "\'coc-prettier',
            "\'coc-docker',
            "\'coc-python',
            "\'coc-tsserver',
            "\'coc-tslint-plugin',
            "\'coc-eslint',
            "\'coc-json',
            "\'coc-html',
            "\'coc-css',
            "\'coc-lists',
            "\'coc-sql',
            "\'coc-omnisharp']

"set shortmess+=c
"command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
"nmap <silent> [c <Plug>(coc-diagnostic-prev)
"nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"function! s:show_documentation()
  "if (index(['vim','help'], &filetype) >= 0)
    "execute 'h '.expand('<cword>')
  "else
    "call CocAction('doHover')
  "endif
"endfunction

"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)

"" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

"augroup mygroup
  "autocmd!
  "" Setup formatexpr specified filetype(s).
  "autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  "" Update signature help on jump placeholder
  "autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end

"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

"" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)

"" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

"" Use `:Format` to format current buffer
"command! -nargs=0 Format :call CocAction('format')

"" Use `:Fold` to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"" use `:OR` for organize import of current buffer
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Using CocList
"" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" List posts
"nnoremap <silent> <space>p  :<C-u>CocList post<CR>

"" UltiSnips Snippets integration
"" Use <C-j> for both expand and jump (make expand higher priority.)
"imap <C-j> <Plug>(coc-snippets-expand-jump)

"" ============================================================================
"" ULTISNIPS
"" ============================================================================
"let g:UltiSnipsExpandTrigger = '<C-j>'

"" ============================================================================
"" FZF
"" ============================================================================
":nnoremap <C-p> :Files<CR>
":nnoremap <Leader>b :Buffers<CR>
"let $BAT_THEME="Nord"
"let $FZF_DEFAULT_COMMAND='ag --nocolor -g ""'

"" ============================================================================
"" BETTER COMMENTS 
"" ============================================================================
"hi def link ErrorBetterComments ErrorMsg 
"hi def link HighlightBetterComments CocUnderline 
"hi def link QuestionBetterComments CursorLineNr 
"hi def link StrikeoutBetterComments CocInfoSign 
"hi def link TodoBetterComments Todo

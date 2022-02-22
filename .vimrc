let g:polyglot_disabled = [
      \'javascript.plugin',
      \'typescript.plugin',
      \'python.plugin',
      \'json.plugin',
      \]

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Core
Plug 'nvim-lua/popup.nvim'
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/NTBBloodbath/rest.nvim.git'
Plug 'https://github.com/neovim/nvim-lspconfig'

" Git
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tommcdo/vim-fugitive-blame-ext.git'
Plug 'https://github.com/sodapopcan/vim-twiggy.git'
Plug 'lewis6991/gitsigns.nvim'
Plug 'https://github.com/rhysd/git-messenger.vim.git'
Plug 'https://github.com/ruanyl/vim-gh-line'
Plug 'sindrets/diffview.nvim'

" Tmux
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/tmux-plugins/vim-tmux-focus-events'

" Theme
Plug 'https://github.com/kristijanhusak/vim-hybrid-material'
Plug 'hoob3rt/lualine.nvim'
Plug 'https://github.com/RRethy/vim-illuminate.git'
Plug 'https://github.com/whatyouhide/vim-lengthmatters.git'
Plug 'https://github.com/blueyed/vim-diminactive.git'

" Explorer
Plug 'https://github.com/nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'https://github.com/kyazdani42/nvim-web-devicons'
Plug 'https://github.com/kyazdani42/nvim-tree.lua'

" Language
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sheerun/vim-polyglot'
Plug 'tami5/lspsaga.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'https://github.com/mattn/emmet-vim.git'
Plug 'https://github.com/alfredodeza/pytest.vim.git'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mhartington/formatter.nvim'

" Auto complete
Plug 'https://github.com/onsails/lspkind-nvim.git'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-calc'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'
Plug 'https://github.com/fhill2/telescope-ultisnips.nvim.git'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'https://github.com/honza/vim-snippets.git'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Misc
Plug 'https://github.com/Lokaltog/vim-easymotion.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'folke/todo-comments.nvim'
Plug 'https://github.com/andymass/vim-matchup.git'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'https://github.com/tom-anders/telescope-vim-bookmarks.nvim.git'
Plug 'https://github.com/AckslD/nvim-neoclip.lua.git'
Plug 'sudormrfbin/cheatsheet.nvim'
" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install'  }
Plug 'https://github.com/dhruvasagar/vim-table-mode'

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
let g:enable_bold_font = 1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

:set termguicolors
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
noremap <Leader><Space> :nohl<CR>

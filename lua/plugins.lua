local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Core
  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',
  {'https://github.com/NTBBloodbath/rest.nvim.git',  commit = 'e5f68db73276c4d4d255f75a77bbe6eff7a476ef' },
  'neovim/nvim-lspconfig',

  -- Git
  'https://github.com/tpope/vim-fugitive.git',
  'https://github.com/tommcdo/vim-fugitive-blame-ext.git',
  'https://github.com/sodapopcan/vim-twiggy.git',
  'lewis6991/gitsigns.nvim',
  'https://github.com/rhysd/git-messenger.vim.git',
  'ruanyl/vim-gh-line',
  'sindrets/diffview.nvim',

  -- Tmux
  'https://github.com/christoomey/vim-tmux-navigator.git',
  'tmux-plugins/vim-tmux-focus-events',

  -- Theme
  'kristijanhusak/vim-hybrid-material',
  'hoob3rt/lualine.nvim',
  'https://github.com/RRethy/vim-illuminate.git',
  'https://github.com/whatyouhide/vim-lengthmatters.git',
  'https://github.com/blueyed/vim-diminactive.git',

  -- Explorer
  { 'nvim-telescope/telescope.nvim', tag = '0.1.3' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'kyazdani42/nvim-web-devicons',
  'kyazdani42/nvim-tree.lua',

  -- Language
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  --use 'sheerun/vim-polyglot'
  'tami5/lspsaga.nvim',
  'editorconfig/editorconfig-vim',
  'https://github.com/mattn/emmet-vim.git',
  'https://github.com/alfredodeza/pytest.vim.git',
  'mfussenegger/nvim-dap',
  'mfussenegger/nvim-dap-python',
  'Pocco81/DAPInstall.nvim',
  'rcarriga/nvim-dap-ui',
  'mhartington/formatter.nvim',

  -- Auto complete
  'https://github.com/onsails/lspkind-nvim.git',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-calc',
  {'tzachar/cmp-tabnine', build = './install.sh' },
  'hrsh7th/nvim-cmp',
  'SirVer/ultisnips',
  'https://github.com/fhill2/telescope-ultisnips.nvim.git',
  'quangnguyen30192/cmp-nvim-ultisnips',
  'https://github.com/honza/vim-snippets.git',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',

  -- Misc
  'https://github.com/Lokaltog/vim-easymotion.git',
  'https://github.com/tpope/vim-surround.git',
  'https://github.com/tpope/vim-unimpaired.git',
  'https://github.com/terryma/vim-multiple-cursors.git',
  'https://github.com/Raimondi/delimitMate.git',
  'https://github.com/scrooloose/nerdcommenter.git',
  'folke/todo-comments.nvim',
  'https://github.com/andymass/vim-matchup.git',
  'MattesGroeger/vim-bookmarks',
  'https://github.com/tom-anders/telescope-vim-bookmarks.nvim.git',
  'https://github.com/AckslD/nvim-neoclip.lua.git',
  'sudormrfbin/cheatsheet.nvim',

  -- If you have nodejs and yarn
  {'iamcco/markdown-preview.nvim', build = 'cd app && npm install' },
  'dhruvasagar/vim-table-mode'
})

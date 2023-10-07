vim.opt.encoding = "utf-8"
vim.opt.wildmenu = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.more = true

vim.cmd("set guioptions-=m")
vim.cmd("set guioptions-=T")

-- Performance boosters
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.lazyredraw = true
vim.opt.re = 1
vim.opt.showcmd = false
vim.opt.synmaxcol = 120
vim.opt.ttyfast = true

vim.cmd([[
  :syntax sync minlines=64
]])

-- Stop vim's crazy formatting when pasting with the mouse
vim.opt.pastetoggle = "<F5>"

-- Reload file if modified
vim.opt.autoread = true

-- Highlight search as you type
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Indents
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.showmatch = true

-- Allow to switch buffers without having to save its changes
vim.opt.hidden = true

-- Do not create backup files
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

-- I like to see hidden spaces, tabs, etc
vim.opt.listchars = "eol:$,tab:>-,trail:-"

-- Hide preview when auto completing
vim.cmd("set completeopt-=preview")

-- Colorscheme
vim.g.enable_bold_font = 1
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("colorscheme hybrid_material")

vim.cmd([[
  let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
]])

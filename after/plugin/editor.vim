"=============================================================================
" TREESITTER
"=============================================================================
set nofoldenable
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldminlines=50
set foldnestmax=2

lua << EOF
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.http = {
  install_info = {
    url = "https://github.com/NTBBloodbath/tree-sitter-http",
    files = { "src/parser.c" },
    branch = "main",
  },
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    "http",
    "comment",
    "tsx",
    "toml",
    "fish",
    "dot",
    "python",
    "javascript",
    "typescript",
    "json",
    "yaml",
    "dockerfile",
    "html",
    "scss",
    "c_sharp",
    "dart",
    "vim",
    "lua"
  },
}
EOF

"=============================================================================
" LSP-SAGA
"=============================================================================

nnoremap <silent>gh :Lspsaga lsp_finder<CR>
nnoremap <silent>gr :Lspsaga rename<CR>
nnoremap <silent>gD :Lspsaga preview_definition<CR>
nnoremap <silent>gd <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

inoremap <silent><C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent><C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent><C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
  border_style = "round",
}
EOF

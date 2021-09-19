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

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
EOF

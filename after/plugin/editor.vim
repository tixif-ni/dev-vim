"=============================================================================
" EDITOR
"=============================================================================

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"=============================================================================
" FORMAT
"=============================================================================

augroup Format
    autocmd!
    autocmd BufWritePost *.js,*.jsx,*.tsx,*.ts,*.py,*.json,*.dart,*.html FormatWrite
augroup END

lua << EOF
local node_formatters = {
  function()
    return {
      exe = "prettier",
      args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
      stdin = true
    }
  end,
}

local json_formatter = {
  function()
    return {
      exe = "prettier",
      args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--double-quote"},
      stdin = true
    }
  end
}

local dart_formatter = {
    function()
      return {
        exe = "~/projects/taxfyle-mobile/flutter/bin/dart",
        args = {"format"},
        stdin = true
      }
    end
}

local htmldjango_formatter = {
    function()
      return {
        exe = "djlint",
        args = {"--reformat", "--preserve-blank-lines", "-"},
        stdin = true
      }
    end
}

require "formatter".setup {
  filetype = {
    typescript = node_formatters,
    javascript = node_formatters,
    javascriptreact = node_formatters,
    typescriptreact = node_formatters,
    dart = dart_formatter,
    lua = {
      -- Pick from defaults:
      require('formatter.filetypes.lua').stylua,

      -- ,or define your own:
      function()
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end
    },
    python = {
      function()
        return {
          exe = "black",
          args = { '-' },
          stdin = true,
        }
      end
    },
    json = json_formatter,
    htmldjango = htmldjango_formatter,
  }
}
EOF

"=============================================================================
" LSP-CONFIG
"=============================================================================

nnoremap gi <cmd>lua vim.lsp.buf.implementation()<cr>

" Disable text object diagnostic to avoid overbloating UI
lua << EOF
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
  )
EOF

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

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false,
  },
  ignore_install = { "phpdoc" },
  ensure_installed = "all",
}
EOF
"=============================================================================
" LSP-SAGA
"=============================================================================

nnoremap <silent>gr :Lspsaga lsp_finder<CR>
nnoremap <silent>gD :Lspsaga preview_definition<CR>
nnoremap <silent>gd <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent><leader>cr :Lspsaga rename<CR>

inoremap <silent><C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent><C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent><C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent><leader>cd :Lspsaga show_line_diagnostics<CR>

nnoremap <silent>gdj :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>gdk :Lspsaga diagnostic_jump_prev<CR>

lua << EOF
 require("lspsaga").init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = ' ',
    dianostic_header_icon = '   ',
    code_action_icon = ' ',
  }
EOF

"=============================================================================
" LSP-KIND
"=============================================================================
lua <<EOF
local lspkind = require("lspkind")
lspkind.init({
  symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = ""
  },
})
EOF

"=============================================================================
" LSP-CMP
"=============================================================================
lua <<EOF
-- require("cmp_tabnine.config"):setup {
  --  max_lines = 1000,
  -- max_num_results = 20,
  -- sort = true,
-- }

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  -- cmp_tabnine = "[TN]",
  path = "[Path]",
  ultisnips = "[Snippets]"
}

local cmp = require("cmp")
cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = require("lspkind").presets.default[vim_item.kind]
      vim_item.menu = source_mapping[entry.source.name]
      return vim_item
    end
  },
  snippet = {
    expand = function(args)
      -- For `ultisnips` user.
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'ultisnips' },
    -- { name = 'cmp_tabnine' },
    { name = 'treesitter' },
  }
}

require('lspconfig').tsserver.setup {
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

require('lspconfig').pyright.setup {
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

-- require('lspconfig').omnisharp.setup {
  -- cmd = { '/usr/local/share/omnisharp/run', "--languageserver", "--hostPID", tostring(vim.fn.getpid())},
-- }
EOF

"=============================================================================
" FLUTTER-TOOLS
"=============================================================================
"
lua <<EOF
  require("flutter-tools").setup {} -- use defaults
EOF

"=============================================================================
" DOGE
"=============================================================================
"
let g:doge_doc_standard_typescript='tsdoc'

"=============================================================================
" ANYFOLD
"=============================================================================
"
set foldlevel=99

"=============================================================================
" OMNISHARP LSP
"=============================================================================
"

lua <<EOF
-- vim.lsp.set_log_level("debug")

local pid = vim.fn.getpid()
-- We need to export he variable DOTNET_ROOT=/usr/local/share/dotnet
local omnisharp_bin = "/Users/jose.blanco/.local/omnisharp/OmniSharp"
-- local util = require('lspconfig').util

local config = {
  -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  -- on_attach = function(_, bufnr)
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- end,
  -- handlers = {
    -- ["textDocument/definition"] = require('omnisharp_extended').handler,
  -- },
  cmd = { omnisharp_bin, '--languageserver' , '--hostPID', tostring(pid) },
  -- rest of your settings
  -- root_dir = function(file, _)
    -- if file:sub(-#".csx") == ".csx" then
      -- return util.path.dirname(file)
    -- end
    -- return util.root_pattern("*.sln")(file) or util.root_pattern("*.csproj")(file)
  -- end,
}

require('omnisharp_extended').telescope_lsp_definitions()
require'lspconfig'.omnisharp.setup(config)
EOF

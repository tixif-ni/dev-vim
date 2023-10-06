-- Disable text object diagnostic to avoid overbloating UI
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false
  })

-- LSP-SAGA
vim.cmd([[
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
]])

 require("lspsaga").init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = ' ',
    diagnostic_header_icon = '   ',
    code_action_icon = ' ',
  }

-- LSP-KIND
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

-- LSP-CMP
require("cmp_tabnine.config"):setup {
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
}

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  cmp_tabnine = "[TN]",
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
    { name = 'cmp_tabnine' },
    { name = 'treesitter' },
  }
}

require('lspconfig').tsserver.setup {
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

require('lspconfig').pyright.setup {
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

require('lspconfig').ruff_lsp.setup {
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

require('lspconfig').terraformls.setup{
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

lua <<EOF
local lspkind = require('lspkind')
lspkind.init({
    -- default: {}
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

    local tabnine = require('cmp_tabnine.config')
    tabnine:setup({
            max_lines = 1000;
            max_num_results = 20;
            sort = true;
    })

  -- Setup nvim-cmp.
  local cmp = require'cmp'
  local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
    ultisnips = "[Snippets]"
}

  cmp.setup({
      formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			if entry.source.name == 'cmp_tabnine' then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. ' ' .. menu
				end
				vim_item.kind = ''
			end
			vim_item.menu = menu
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
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
  })

  -- Setup lspconfig.
  require('lspconfig').tsserver.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
EOF

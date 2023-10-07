-- Disable text object diagnostic to avoid overbloating UI
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
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

return {
	"neovim/nvim-lspconfig",
	{
		"kkharji/lspsaga.nvim",
		opts = {
			error_sign = "",
			warn_sign = "",
			hint_sign = "",
			infor_sign = " ",
			diagnostic_header_icon = "   ",
			code_action_icon = " ",
		},
	},
	{
		"https://github.com/onsails/lspkind-nvim.git",
		opts = {
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
				TypeParameter = "",
			},
		},
		config = function(opts)
			require("lspkind").init(opts)

			require("lspconfig").tsserver.setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(
					vim.lsp.protocol.make_client_capabilities()
				),
			})

			require("lspconfig").pyright.setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(
					vim.lsp.protocol.make_client_capabilities()
				),
			})

			require("lspconfig").ruff_lsp.setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(
					vim.lsp.protocol.make_client_capabilities()
				),
			})

			require("lspconfig").terraformls.setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(
					vim.lsp.protocol.make_client_capabilities()
				),
			})

			require("lspconfig").lua_ls.setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(
					vim.lsp.protocol.make_client_capabilities()
				),
			})
		end,
	},
}

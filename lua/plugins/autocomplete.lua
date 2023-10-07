local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
	ultisnips = "[Snippets]",
}

return {
	"L3MON4D3/LuaSnip",
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		opts = {
			max_lines = 1000,
			max_num_results = 20,
			sort = true,
		},
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local cmp = require("cmp")

			return {
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = require("lspkind").presets.default[vim_item.kind]
						vim_item.menu = source_mapping[entry.source.name]
						return vim_item
					end,
				},
				snippet = {
					expand = function(args)
						-- For `luasnip` user.
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "calc" },
					{ name = "ultisnips" },
					{ name = "cmp_tabnine" },
					{ name = "treesitter" },
				},
			}
		end,
	},
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-calc",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
	"hrsh7th/cmp-nvim-lsp",
	"saadparwaiz1/cmp_luasnip",
}

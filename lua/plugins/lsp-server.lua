return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		init = function()
			-- Disable text object diagnostic next to each line to avoid overbloating UI
			vim.diagnostic.config({ virtual_text = false })

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", opts)
					vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>", opts)
					vim.keymap.set("n", "gt", ":Telescope lsp_type_definitions<CR>", opts)
					vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
				end,
			})

			local diagnostic_icons = { Error = "", Warn = "", Hint = "💡", Info = " " }
			for severity, icon in pairs(diagnostic_icons) do
				local hl = "DiagnosticSign" .. severity
				vim.fn.sign_define(hl, { text = icon, texthl = hl })
			end
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-nvim-lsp",
			"tzachar/cmp-tabnine",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			{
				"tzachar/cmp-tabnine",
				build = "./install.sh",
				opts = {
					max_lines = 1000,
					max_num_results = 20,
					sort = true,
				},
			},
			"https://github.com/onsails/lspkind-nvim.git",
			"neovim/nvim-lspconfig",
		},
		opts = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			return {
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
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
						before = function(entry, vim_item)
							local source_mapping = {
								nvim_lsp = "[LSP]",
								buffer = "[Buffer]",
								path = "[Path]",
								luasnip = "[Snippets]",
								cmp_tabnine = "[TN]",
								treesitter = "[TS]",
							}

							vim_item.menu = source_mapping[entry.source.name]

							return vim_item
						end,
					}),
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
					{ name = "luasnip" },
					{ name = "cmp_tabnine" },
					{ name = "treesitter" },
				},
			}
		end,
		init = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lsp_servers = {
				[1] = "tsserver",
				[2] = "pyright",
				[3] = "ruff_lsp",
				[4] = "terraformls",
				[5] = "lua_ls",
			}

			for _, server in ipairs(lsp_servers) do
				require("lspconfig")[server].setup({
					capabilities = capabilities,
				})
			end
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"kosayoda/nvim-lightbulb",
		opts = {
			autocmd = { enabled = true },
		},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"kosayoda/nvim-lightbulb",
			"rest-nvim/rest.nvim",
		},
		opts = function()
			local null_ls = require("null-ls")

			return {
				sources = {
					null_ls.builtins.code_actions.gitsigns.with({
						config = {
							filter_actions = function(title)
								return title:lower():match("blame") == nil
							end,
						},
					}),
					null_ls.builtins.hover.printenv,
				},
			}
		end,
		init = function()
			local null_ls = require("null-ls")
			local utils = require("utils.text")

			local http_action_source = {
				method = null_ls.methods.CODE_ACTION,
				filetypes = { "http" },
				generator = {
					fn = function(params)
						local actions = {}
						local line = params.content[params.row]

						if
							utils.startswith(line, "GET")
							or utils.startswith(line, "POST")
							or utils.startswith(line, "PUT")
							or utils.startswith(line, "PATCH")
							or utils.startswith(line, "DELETE")
						then
							table.insert(actions, {
								title = "Execute HTTP request",
								action = require("rest-nvim").run,
							})
						end

						return actions
					end,
				},
			}

			null_ls.register(http_action_source)
		end,
	},
}

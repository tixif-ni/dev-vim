return {
	"preservim/nerdcommenter",
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			keywords = {
				FIX = {
					icon = " ",
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			},
		},
		init = function()
			vim.cmd([[
              command! TodoCurrent execute 'TodoQuickFix cwd='.expand("%:p")
            ]])
		end,
	},
	"https://github.com/mattn/emmet-vim.git",
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = "all",
			ignore_install = { "phpdoc" },
			highlight = {
				enable = true,
			},
		},
		init = function()
			vim.opt.foldenable = false
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldminlines = 50
			vim.opt.foldnestmax = 2
		end,
	},
	{
		"mhartington/formatter.nvim",
		opts = function()
			return {
				filetype = {
					typescript = {
						require("formatter.filetypes.typescript").prettier,
					},
					javascript = {
						require("formatter.filetypes.javascript").prettier,
					},
					javascriptreact = {
						require("formatter.filetypes.javascriptreact").prettier,
					},
					python = {
						require("formatter.filetypes.python").black,
					},
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					json = {
						require("formatter.filetypes.json").prettier,
					},
					toml = {
						require("formatter.filetypes.toml"),
					},
					yaml = {
						require("formatter.filetypes.yaml").prettier,
					},
					markdown = {
						require("formatter.filetypes.markdown").prettier,
					},
					htmldjango = {
						function()
							local util = require("formatter.util")
							local djlintrc = vim.fn.findfile(".djlintrc", util.get_current_buffer_file_path() .. ";")

							return {
								exe = "djlint",
								args = {
									"-",
									"--reformat",
									"--profile",
									"django",
									"--configuration",
									djlintrc,
								},
								stdin = true,
							}
						end,
					},
					terraform = {
						function()
							return {
								exe = "terraform",
								args = {
									"fmt",
									"-",
								},
								stdin = true,
							}
						end,
					},
				},
			}
		end,
		init = function()
			vim.cmd([[
              augroup FormatAutogroup
                  autocmd!
                  autocmd BufWritePost *.js,*.jsx,*.ts,*.json,*.py,*.lua,*.toml,*.yaml,*.md,*.html,*.tf FormatWrite
              augroup END
            ]])
		end,
	},
}

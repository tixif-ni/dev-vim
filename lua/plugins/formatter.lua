return {
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

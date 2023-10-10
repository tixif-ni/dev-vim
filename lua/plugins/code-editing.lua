return {
	"preservim/nerdcommenter",
	"https://github.com/mattn/emmet-vim.git",
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				ignore_install = { "phpdoc" },
				highlight = {
					enable = true,
					-- Disable slow treesitter highlight for large files
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				matchup = {
					enable = true,
				},
			})
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
					jsonc = {
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
							local current_path = vim.fn.expand("%:p")
							local djlintrc = vim.fn.findfile(".djlintrc", current_path .. ";")

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

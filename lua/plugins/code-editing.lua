local constants = require("constants")

return {
    "https://github.com/mattn/emmet-vim.git",
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                ignore_install = { "phpdoc" },
                highlight = {
                    enable = true,
                    -- Disable slow treesitter highlight for large files
                    disable = function(_, buf)
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
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            ["of"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["oc"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["ob"] = "@block.outer",
                            ["ib"] = "@block.inner",
                            ["op"] = "@parameter.inner",
                            ["ip"] = "@parameter.inner",
                        },
                    },
                },
            })
        end,
        init = function()
            local ts = require("vim.treesitter")

            ts.query.add_directive("set_if_eq!", function(match, pattern, bufnr, predicate, metadata)
                local _, key, capture_id, rhs = unpack(predicate)

                local node = match[capture_id]
                if node and ts.get_node_text(node, bufnr) == rhs then
                    metadata[key] = true
                end
            end)
        end,
    },
    {
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = function()
            local List = require("plenary.collections.py_list")

            return {
                backends = { "treesitter", "lsp" },
                ignore = {
                    filetypes = List({ "markdown" }):concat(constants.ignored_buffer_types),
                },
                post_parse_symbol = function(bufnr, item, ctx)
                    local ts = require("vim.treesitter")

                    if ctx.backend_name == "treesitter" then
                        if ctx.match.private then
                            item.name = " " .. item.name
                        elseif ctx.match.protected then
                            item.name = " " .. item.name
                        end
                    end

                    return true
                end,
                float = {
                    override = function(conf)
                        conf.width = 40
                        return conf
                    end,
                },
            }
        end,
        cmd = { "AerialToggle" },
        keys = {
            { "gc", ":AerialToggle float<CR>", desc = "[Code] Navigation", mode = "n" },
        },
    },
    {
        "andersevenrud/nvim_context_vt",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = function()
            local List = require("plenary.collections.py_list")

            return {
                enabled = false,
                disable_ft = List({ "markdown" }):concat(constants.ignored_buffer_types),
            }
        end,
        keys = {
            { "<leader><space>", ":NvimContextVtToggle<CR>", desc = "[Code] Show Context", mode = "n" },
        },
    },
    {
        "mhartington/formatter.nvim",
        cmd = { "FormatWrite" },
        opts = function()
            return {
                filetype = {
                    typescript = {
                        require("formatter.filetypes.typescript").prettier,
                    },
                    typescriptreact = {
                        require("formatter.filetypes.typescriptreact").prettier,
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
                    rust = {
                        require("formatter.filetypes.rust").rustfmt,
                    },
                },
            }
        end,
        init = function()
            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = {
                    "*.js",
                    "*.jsx",
                    "*.ts",
                    "*.tsx",
                    "*.json",
                    "*.py",
                    "*.lua",
                    "*.toml",
                    "*.yaml",
                    "*.md",
                    "*.html",
                    "*.tf",
                    "*.rs",
                },
                group = vim.api.nvim_create_augroup("FormatAutogroup", {}),
                command = "FormatWrite",
            })
        end,
    },
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            { "JoosepAlviste/nvim-ts-context-commentstring", opts = {} },
        },
        opts = function()
            return {
                padding = false,
                toggler = {
                    line = "<leader>cc",
                    block = "<leader>cb",
                },
                opleader = {
                    line = "<leader>cc",
                    block = "<leader>cb",
                },
                mappings = {
                    extra = false,
                },
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
    },
}

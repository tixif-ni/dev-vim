local constants = require("constants")

return {
    "https://github.com/mattn/emmet-vim.git",
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "rust",
                "typescript",
                "javascript",
                "tsx",
                "html",
                "css",
                "json",
                "toml",
                "yaml",
                "bash",
                "c_sharp",
                "python",
                "terraform",
                "markdown",
                "markdown_inline",
                "sql",
            })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
    {
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            local ts = require("vim.treesitter")

            -- Custom directive used by the aerial queries in queries/.
            -- Neovim 0.12 hands directive handlers a TSNode[] list per
            -- capture instead of a single TSNode, so unwrap before comparing.
            ts.query.add_directive("set_if_eq!", function(match, _, bufnr, predicate, metadata)
                local _, key, capture_id, rhs = unpack(predicate)

                local nodes = match[capture_id]
                if type(nodes) == "userdata" then
                    nodes = { nodes }
                end
                local node = nodes and nodes[1]
                if node and ts.get_node_text(node, bufnr) == rhs then
                    metadata[key] = true
                end
            end, { force = true })
        end,
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
    {
        "akinsho/flutter-tools.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim", -- optional for vim.ui.select
        },
        config = true,
    },
    {
        "davidmh/mdx.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}

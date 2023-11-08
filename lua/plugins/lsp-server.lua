local constants = require("constants")

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        init = function()
            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set(
                        "n",
                        "gd",
                        ":Telescope lsp_definitions show_line=false theme=ivy initial_mode=normal jump_type=never<CR>",
                        opts
                    )
                    vim.keymap.set(
                        "n",
                        "gi",
                        ":Telescope lsp_implementations show_line=false theme=ivy initial_mode=normal jump_type=never<CR>",
                        opts
                    )
                    vim.keymap.set(
                        "n",
                        "gt",
                        ":Telescope lsp_type_definitions show_line=false theme=ivy initial_mode=normal jump_type=never<CR>",
                        opts
                    )
                    vim.keymap.set(
                        "n",
                        "gr",
                        ":Telescope lsp_references include_declaration=false show_line=false theme=ivy initial_mode=normal<CR>",
                        opts
                    )
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "fa", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
                end,
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        init = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lsp",
            "ray-x/cmp-treesitter",
            "saadparwaiz1/cmp_luasnip",
            "https://github.com/onsails/lspkind-nvim.git",
            "neovim/nvim-lspconfig",
        },
        opts = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local source_mapping = {
                nvim_lsp = "力",
                buffer = "",
                path = "",
                luasnip = "",
                treesitter = "",
            }

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
                    { name = "treesitter" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "calc" },
                },
            }
        end,
        init = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lsp_servers = {
                tsserver = {},
                pyright = {},
                ruff_lsp = {
                    on_attach = function(client, _)
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end,
                },
                terraformls = {},
                lua_ls = {},
            }

            for server, opts in pairs(lsp_servers) do
                opts.capabilities = capabilities
                require("lspconfig")[server].setup(opts)
            end
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "nvimtools/none-ls.nvim",
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
                    null_ls.builtins.diagnostics.djlint,
                },
            }
        end,
    },
}

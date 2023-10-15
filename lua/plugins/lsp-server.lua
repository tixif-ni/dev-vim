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
                    vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", opts)
                    vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>", opts)
                    vim.keymap.set("n", "gt", ":Telescope lsp_type_definitions<CR>", opts)
                    vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
                end,
            })
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
            local lsp_servers = { "tsserver", "pyright", "ruff_lsp", "terraformls", "lua_ls" }

            for i = 1, #lsp_servers do
                require("lspconfig")[lsp_servers[i]].setup({
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
            -- Set a higher priority so it replaces current sign on hover if any
            -- https://neovim.io/doc/user/diagnostic.html#diagnostic-signs
            priority = 11,
            autocmd = { enabled = true },
            sign = {
                text = "",
            },
            ignore = {
                ft = {
                    "fugitive",
                    "fugitiveblame",
                    "DiffviewFiles",
                    "NvimTree",
                },
            },
        },
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        opts = {},
        keys = {
            {
                "<space>",
                function()
                    local virtual_lines = vim.diagnostic.config().virtual_lines

                    if type(virtual_lines) == "table" then
                        vim.diagnostic.config({ virtual_lines = false })
                    else
                        vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
                    end
                end,
                desc = "[Bookmark] Toggle",
                mode = "n",
            },
            {
                "<leader><space>",
                function()
                    local virtual_lines = vim.diagnostic.config().virtual_lines

                    if type(virtual_lines) == "table" then
                        vim.diagnostic.config({ virtual_lines = false })
                    else
                        vim.diagnostic.config({ virtual_lines = not virtual_lines })
                    end
                end,
                desc = "[Bookmark] Toggle",
                mode = "n",
            },
        },
        init = function()
            -- Disable text object diagnostic next to each line to avoid overbloating UI
            vim.diagnostic.config({ virtual_text = false, virtual_lines = false })

            -- Setup icons
            local diagnostic_icons = { Error = "✗", Warn = "", Hint = "", Info = " " }
            for severity, icon in pairs(diagnostic_icons) do
                local hl = "DiagnosticSign" .. severity
                vim.fn.sign_define(hl, { text = icon, texthl = hl })
            end
        end,
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
                    null_ls.builtins.formatting.prettier.with({
                        extra_filetypes = { "toml" },
                    }),
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.diagnostics.djlint,
                    null_ls.builtins.formatting.djlint,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.terraform_fmt,
                },

                on_attach = function(client, bufnr)
                    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({
                                    async = false,
                                    filter = function(buffer_client)
                                        -- Run only these formatters
                                        return buffer_client.name == "null-ls"
                                    end,
                                })
                            end,
                        })
                    end
                end,
            }
        end,
    },
}

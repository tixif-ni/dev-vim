local constants = require("constants")

return {
    {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("github-theme").setup({
                groups = {
                    all = {
                        DiagnosticHint = { fg = "#0969DA" },
                        DiagnosticVirtualTextHint = { fg = "#0969DA" },
                        DiagnosticUnderlineHint = {
                            sp = "#0969DA",
                            style = "undercurl",
                        },
                        DiagnosticFloatingHint = { fg = "#0969DA" },
                    },
                },
            })

            -- Nvim 0.11+ auto-sets 'background' from OSC 11 terminal color
            -- reports, which flips it to dark (and breaks the colorscheme)
            -- when iTerm2 re-reports its colors on window resize. Setting
            -- 'background' from Lua does NOT disable this (nvim can't tell
            -- user Lua from its own SID_LUA setter), so delete the
            -- auto-detection autocmd directly.
            vim.opt.background = "light"
            -- pcall: the nvim.tty group only exists when a TUI is attached
            local ok, aus = pcall(vim.api.nvim_get_autocmds, { event = "TermResponse", group = "nvim.tty" })
            for _, au in ipairs(ok and aus or {}) do
                if (au.desc or ""):find("'background'", 1, true) then
                    pcall(vim.api.nvim_del_autocmd, au.id)
                end
            end
            vim.cmd("colorscheme github_light_default")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                theme = "material",
                -- theme = "vscode",
            },
            sections = {
                lualine_c = {
                    "filename",
                    "aerial",
                },
                lualine_x = { "encoding", "fileformat" },
            },
            extensions = { "nvim-tree", "quickfix", "fugitive" },
        },
    },
    {
        "https://github.com/RRethy/vim-illuminate.git",
        config = function()
            require("illuminate").configure({
                filetypes_denylist = constants.ignored_buffer_types,
            })
        end,
    },
    {
        "https://github.com/whatyouhide/vim-lengthmatters.git",
        config = function()
            vim.g.lengthmatters_start_at_column = 88
        end,
    },
    --{
    --    "https://github.com/levouh/tint.nvim.git",
    --    opts = {
    --        window_ignore_function = function(winid)
    --            local bufid = vim.api.nvim_win_get_buf(winid)
    --            local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")
    --            local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

    --            -- Do not tint under these conditions
    --            return filetype == "NvimTree" or floating
    --        end,
    --    },
    --},
    {
        "norcalli/nvim-colorizer.lua",
        opts = { "css", "sass", "scss" },
    },
}

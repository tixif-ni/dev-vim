local constants = require("constants")

return {
    --{
    --"kristijanhusak/vim-hybrid-material",
    --lazy = false, -- make sure we load this during startup
    --priority = 1000, -- make sure to load this before all the other start plugins
    --config = function()
    --vim.g.enable_bold_font = 1
    --vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

    --vim.opt.termguicolors = true
    --vim.opt.background = "dark"
    --vim.cmd("colorscheme hybrid_material")
    --end,
    --},
    {
        "Mofiqul/vscode.nvim",
        lazy = false, -- make sure we load this during startup
        priority = 1000, -- make sure to load this before all the other start plugins
        init = function()
            vim.opt.background = "dark"
            require("vscode").load()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                --theme = "material",
                theme = "vscode",
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
    {
        "https://github.com/levouh/tint.nvim.git",
        opts = {
            window_ignore_function = function(winid)
                local bufid = vim.api.nvim_win_get_buf(winid)
                local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")
                local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

                -- Do not tint under these conditions
                return filetype == "NvimTree" or floating
            end,
        },
    },
    { "stevearc/dressing.nvim", opts = {} },
    {
        "norcalli/nvim-colorizer.lua",
        opts = { "css", "sass", "scss" },
    },
}

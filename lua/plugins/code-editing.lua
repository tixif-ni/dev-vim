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
            })
        end,
    },
    {
        "https://github.com/nvim-treesitter/nvim-treesitter-context.git",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
        keys = {
            {
                "gc",
                function()
                    require("treesitter-context").go_to_context()
                end,
                mode = "n",
            },
        },
    },
    {
        "https://github.com/radyz/diagnostic-window.nvim.git",
        dependencies = { "MunifTanjim/nui.nvim" },
        keys = {
            {
                "<space>",
                ":DiagWindowShow<CR>",
                mode = "n",
            },
        },
    },
}

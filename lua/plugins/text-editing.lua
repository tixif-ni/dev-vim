return {
    "https://github.com/tpope/vim-surround.git",
    "mg979/vim-visual-multi",
    "https://github.com/Raimondi/delimitMate.git",
    {
        "https://github.com/andymass/vim-matchup.git",
        init = function()
            vim.g.matchup_matchparen_deferred = 1
        end,
    },
    {
        "https://github.com/AckslD/nvim-neoclip.lua.git",
        opts = {
            history = 100,
            keys = {
                telescope = {
                    i = {
                        select = "<CR>",
                        paste = "<C-p>",
                        paste_behind = "<C-P>",
                    },
                    n = {
                        select = "<CR>",
                        paste = "p",
                        paste_behind = "P",
                    },
                },
            },
        },
    },
    {
        "https://github.com/easymotion/vim-easymotion.git",
        lazy = false,
        keys = {
            { "/", "<Plug>(easymotion-sn)", mode = "n", desc = "[Text] Search", noremap = true },
            { "/", "<Plug>(easymotion-tn)", mode = "o", desc = "[Text] Search", noremap = true },
        },
    },
    {
        "nvim-pack/nvim-spectre",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = {
            "Spectre",
        },
        keys = {
            {
                "q",
                function()
                    require("spectre").close()
                end,
                mode = "n",
                desc = "[Text] Close search",
                ft = { "spectre_panel" },
                noremap = true,
            },
        },
        commander = {
            {
                desc = "[Text] Search & Replace",
                cmd = function()
                    require("spectre").open_visual({ select_word = true })
                end,
            },
            {
                desc = "[Text] Search & Replace file",
                cmd = function()
                    require("spectre").open_file_search({ select_word = true })
                end,
            },
        },
    },
    {
        "nvimdev/hlsearch.nvim",
        event = "BufRead",
        opts = {},
    },
}

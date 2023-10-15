local utils = require("utils.git")

return {
    {
        "FeiyouG/commander.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        opts = function()
            return {
                components = {
                    "DESC",
                    "CMD",
                    "KEYS",
                },
                sorty_by = {
                    "DESC",
                    "KEYS",
                },
                integration = {
                    lazy = {
                        enable = true,
                    },
                    telescope = {
                        enable = true,
                    },
                },
            }
        end,
        keys = {
            { "<leader>fc", ":Telescope commander<CR>", mode = "n" },
        },
    },
}

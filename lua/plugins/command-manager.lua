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
                    "KEYS",
                },
                sorty_by = {
                    "DESC",
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
            { "fc", ":Telescope commander<CR>", mode = "n" },
        },
    },
}

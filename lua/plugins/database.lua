return {
    { "tpope/vim-dadbod", commit = "e95afed23712f969f83b4857a24cf9d59114c2e6" },
    {
        "radyz/vim-dadbod-wrapper",
        opts = {
            env_prefix = "DADBOD_",
        },
        ft = { "sql" },
        keys = {
            {
                "<localleader>r",
                function()
                    require("telescope").extensions.dadbod_wrapper.connections(
                        require("telescope.themes").get_dropdown({
                            initial_mode = "normal",
                        })
                    )
                end,
                ft = { "sql" },
                mode = { "n", "v" },
            },
            {
                "<localleader>p",
                function()
                    require("vim-dadbod-wrapper")
                end,
                ft = { "dboutpreview" },
                mode = { "n" },
            },
        },
    },
    {
        dir = vim.fn.stdpath("config") .. "/lua/local-plugins/pgsql-tools",
        keys = {
            {
                "<localleader><space>",
                function()
                    require("pgsql-tools").inspect()
                end,
                ft = { "dbout" },
                mode = "n",
                desc = "[PGSQL] Preview",
                noremap = true,
            },
        },
    },
}

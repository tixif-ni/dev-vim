return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		actions = {
			open_file = {
				resize_window = false,
			},
		},
		filters = {
			dotfiles = true,
			custom = {
				"^.git$",
				"^.cache$",
				".pyc",
				".pyo",
				"__pycache__",
				"bower_components",
				"DS_Store",
			},
		},
		diagnostics = {
			enable = true,
		},
		git = {
			ignore = false,
		},
		renderer = {
			indent_markers = {
				enable = true,
			},
		},
	},
	keys = {
		{ "<leader>nt", ":NvimTreeToggle<CR>", desc = "Toggles tree display", mode = "n" },
		{ "<leader>nf", ":NvimTreeFindFile<CR>", desc = "Finds file in tree", mode = "n" },
		{ "<leader>nr", ":NvimTreeRefresh<CR>", desc = "Refreshes tree items", mode = "n" },
	},
}

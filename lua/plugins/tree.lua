vim.cmd([[
  nnoremap <leader>nt :NvimTreeToggle<CR>
  nnoremap <leader>nf :NvimTreeFindFile<CR>
  nnoremap <leader>nr :NvimTreeRefresh<CR>
]])

require'nvim-tree'.setup {
    actions = {
        open_file = {
            resize_window = false
        }
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
            "DS_Store"
        }
    },
    diagnostics = {
        enable = true
    },
    git = {
        ignore = false
    },
    renderer = {
        indent_markers = {
          enable = true
        }
    }
}

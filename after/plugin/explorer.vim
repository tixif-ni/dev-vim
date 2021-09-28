"=============================================================================
" TELESCOPE
"=============================================================================

autocmd User TelescopePreviewerLoaded setlocal number
command! -nargs=1 Livegrep lua require('telescope.builtin').live_grep({search_dirs={'<args>'}})

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fw <cmd>Telescope grep_string<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
nnoremap <leader>fdf <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <leader>fda <cmd>Telescope lsp_workspace_diagnostics<cr>
nnoremap <leader>fma <cmd>Telescope vim_bookmarks all<cr>
nnoremap <leader>fmf <cmd>Telescope vim_bookmarks current_file<cr>
nnoremap <leader>fc <cmd>TodoTelescope<cr>

lua << EOF
require'telescope'.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('vim_bookmarks')
EOF

"=============================================================================
" TREE
"=============================================================================

nnoremap <leader>tt :NvimTreeToggle<CR>
nnoremap <leader>tf :NvimTreeFindFile<CR>
nnoremap <leader>tr :NvimTreeRefresh<CR>

let g:nvim_tree_side = 'left'
let g:nvim_tree_width = 30
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_hide_dotfiles = 1
let g:nvim_tree_lsp_diagnostics = 1
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
let g:nvim_tree_ignore = [
            \'.git',
            \'.cache',
            \'__pycache__',
            \'.pyc',
            \'.pyo',
            \'bower_components',
            \'DS_Store',
            \]
let g:nvim_tree_special_files = {
            \'README.md': 1,
            \'Makefile': 1,
            \'MAKEFILE': 1
            \}
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

lua <<EOF
require'nvim-tree'.setup() 
EOF

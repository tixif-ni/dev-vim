"=============================================================================
" TELESCOPE
"=============================================================================

autocmd User TelescopePreviewerLoaded setlocal number
command! -nargs=1 Livegrep lua require('telescope.builtin').live_grep({search_dirs={'<args>'}})

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fw <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
nnoremap <leader>fdf <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <leader>fda <cmd>Telescope lsp_workspace_diagnostics<cr>
nnoremap <leader>fma <cmd>Telescope vim_bookmarks all<cr>
nnoremap <leader>fmf <cmd>Telescope vim_bookmarks current_file<cr>
nnoremap <leader>fc <cmd>TodoTelescope<cr>
nnoremap <leader>fy <cmd>Telescope neoclip<cr>
nnoremap <leader>fs <cmd>Telescope ultisnips<cr>

lua << EOF
local actions = require "telescope.actions"

require'telescope'.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = false,
        ["<C-p>"] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
  pickers = {
    buffers = {
        mappings = {
          n = {
            ["dd"] = actions.delete_buffer,
          }
        }
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('vim_bookmarks')
require('telescope').load_extension('neoclip')
require('telescope').load_extension('ultisnips')

-- LOCAL EXTENSIONS
require('telescope').load_extension('git_grep_string')
require('telescope').load_extension('git_live_grep')

local git_pickers = require'telescope.builtin.git'
local git_utils = require'utils.git'

require'telescope.builtin'.git_files = function(opts)
  return git_pickers.files(git_utils.set_git_root(opts))
end

require'telescope.builtin'.git_commits = function(opts)
  return git_pickers.commits(git_utils.set_git_root(opts))
end

require'telescope.builtin'.git_bcommits = function(opts)
  return git_pickers.bcommits(git_utils.set_git_root(opts))
end

require'telescope.builtin'.git_branches = function(opts)
  return git_pickers.branches(git_utils.set_git_root(opts))
end

require'telescope.builtin'.git_status = function(opts)
  return git_pickers.status(git_utils.set_git_root(opts))
end
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
require'nvim-tree'.setup {
  view = {
    width = 35,
  }
}
EOF

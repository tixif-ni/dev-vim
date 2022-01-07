"=============================================================================
" TELESCOPE
"=============================================================================

autocmd User TelescopePreviewerLoaded setlocal number
command! -nargs=1 Livegrep lua require('telescope.builtin').live_grep({search_dirs={'<args>'}})

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fl <cmd>Telescope live_grep<cr>
nnoremap <leader>fp <cmd>Telescope find_project_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fw <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fgf <cmd>Telescope git_files<cr>
nnoremap <leader>fgl <cmd>Telescope git_local git_live_grep<cr>
nnoremap <leader>fgw <cmd>Telescope git_local git_grep_string<cr>
nnoremap <leader>fgc <cmd>Telescope git_commits<cr>
nnoremap <leader>fma <cmd>Telescope vim_bookmarks all<cr>
nnoremap <leader>fmf <cmd>Telescope vim_bookmarks current_file<cr>
nnoremap <leader>fdf <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <leader>fda <cmd>Telescope lsp_workspace_diagnostics<cr>
nnoremap <leader>fc <cmd>TodoTelescope<cr>
nnoremap <leader>fy <cmd>Telescope neoclip<cr>
nnoremap <leader>fs <cmd>Telescope ultisnips<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>

nnoremap <leader>fh <cmd>Telescope search_history<cr>
nnoremap <leader>fch <cmd>Telescope command_history<cr>

lua << EOF
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local git_pickers = require'telescope.builtin.git'
local internal_pickers = require'telescope.builtin.internal'

local diffview = require"diffview"
local git_utils = require'utils.git'

require('telescope.builtin').find_project_files = function(opts)
  path = vim.fn.finddir(".git", vim.fn.expand('%:p:h')..';')
  root = vim.fn.fnamemodify(vim.fn.substitute(path, ".git", "", ""), ":p:h")

  opts.cwd = root

  require'telescope.builtin'.find_files(opts)
end

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
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('vim_bookmarks')
require('telescope').load_extension('neoclip')
require('telescope').load_extension('ultisnips')

-- LOCAL EXTENSIONS
require('telescope').load_extension('git_local')

require'telescope.builtin'.buffers = function(opts)
  opts = opts or {}
  opts.attach_mappings = function(_, map)
    map('n', 'dd', actions.delete_buffer)

    return true
  end

  return internal_pickers.buffers(opts)
end

require'telescope.builtin'.git_files = function(opts)
  return git_pickers.files(git_utils.set_git_root(opts))
end

require'telescope.builtin'.git_commits = function(opts)
  opts = git_utils.set_git_root(opts)

  opts.attach_mappings = function(_, map)
    map('n', 'dd', function(prompt_bufnr)
      local cwd = action_state.get_current_picker(prompt_bufnr).cwd
      local selection = action_state.get_selected_entry()

      if selection ~= nil then
        diffview.open(selection.value.."^!", "-C"..cwd)
      end
    end)

    return true
  end

  return git_pickers.commits(opts)
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

nnoremap <leader>nt :NvimTreeToggle<CR>
nnoremap <leader>nf :NvimTreeFindFile<CR>
nnoremap <leader>nr :NvimTreeRefresh<CR>

let g:nvim_tree_side = 'left'
let g:nvim_tree_auto_resize = 1
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
require'nvim-tree.lib'.toggle_ignored()
EOF

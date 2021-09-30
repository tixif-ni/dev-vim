"=============================================================================
" FUGITIVE
"=============================================================================

autocmd VimEnter * if empty(expand('<amatch>'))|call FugitiveDetect(getcwd())|endif
:nnoremap <Leader>gf :!git fetch --all<CR>
:nnoremap <Leader>gb :Git blame<CR>
:nnoremap <Leader>gs :Git<CR>
:nnoremap <Leader>gc :Git commit<CR>
:nnoremap <Leader>gp :Git push<CR>
:nnoremap <Leader>gr :Gread<CR>
:nnoremap gdh :diffget //2<CR>
:nnoremap gdl :diffget //3<CR>

"=============================================================================
" DIFFVIEW
"=============================================================================

:nnoremap <Leader>gdf :DiffviewFileHistory<CR>
:nnoremap <Leader>gda :DiffviewOpen<CR>

lua << EOF
require'diffview'.setup {
  key_bindings = {
    view = {
      ["gq"] = "<CMD>DiffviewClose<CR>",
    },
    file_panel = {
      ["gq"] = "<CMD>DiffviewClose<CR>",
    },
    file_history_panel = {
      ["gq"] = "<CMD>DiffviewClose<CR>",
    }
  }
}
EOF

"=============================================================================
" GH-LINE
"=============================================================================

nmap <leader>gy <Plug>(gh-line)
let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

"=============================================================================
" TWIGGY
"=============================================================================

:nnoremap <Leader>gt :Twiggy<CR>

"=============================================================================
" GV
"=============================================================================

:nnoremap <Leader>gl :GV<CR>
:nnoremap <Leader>glf :GV!<CR>

"=============================================================================
" GITSIGNS
"=============================================================================

lua << EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n <leader>ghj'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n <leader>ghk'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>ghR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>ghb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>ghS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <leader>ghU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
    ['n <leader>gha'] = '<cmd>lua require"gitsigns".setloclist()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_index = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
  },
  current_line_blame_formatter_opts = {
    relative_time = false
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
EOF

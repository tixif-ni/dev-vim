"=============================================================================
" FUGITIVE
"=============================================================================

autocmd VimEnter * if empty(expand('<amatch>'))|call FugitiveDetect(getcwd())|endif
:nnoremap <Leader>gf :!git fetch --all<CR>
:nnoremap <Leader>gb :Git blame<CR>
:nnoremap <Leader>gs :Git<CR>
:nnoremap <Leader>gc :Git commit<CR>
:nnoremap <Leader>gr :Gread<CR>
:nnoremap <Leader>gl :Git log<CR>
:nnoremap gdh :diffget //2<CR>
:nnoremap gdl :diffget //3<CR>

augroup git_fugitive
  autocmd!
  autocmd Filetype fugitive :nnoremap <buffer> <Leader>gp :Git push<CR>
augroup end

"=============================================================================
" DIFFVIEW
"=============================================================================

:nnoremap <Leader>gdf :DiffviewFileHistory<CR>
:nnoremap <Leader>gda :DiffviewOpen<CR>
:nnoremap <Leader>gdt <cmd>lua diffview_from_log()<CR>

augroup git_diffview
  autocmd!
  autocmd Filetype git :nnoremap <buffer> <Leader>dd <cmd>lua diffview_fugitive()<CR>
  autocmd Filetype fugitiveblame :nnoremap <buffer> <Leader>dd <cmd>lua diffview_fugitive()<CR>
augroup end

lua << EOF
local diffview = require"diffview"
diffview.setup {
  file_panel = {
    width = 50
  },
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

function trim(s)
   return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function diffview_fugitive ()
  local line = vim.fn.getline(".")

  local log_line = line:match "[commit|Merge:] ([a-f0-9 ]+)"
  if log_line ~= nil then
    log_line = trim(log_line)
  end

  local blame_line = line:match "([a-f0-9]+)."
  if blame_line ~= nil then
    blame_line = trim(blame_line)
  end

  if log_line ~= nil and string.len(log_line) > 7 then
    hash = log_line
  elseif blame_line ~= nil and string.len(blame_line) > 7 then
    hash = blame_line
  else
    return
  end

  if string.find(hash, " ") then
    hash = vim.fn.substitute(hash, " ", "..", "")
  else
    hash = hash.."^!"
  end

  local git_dir = vim.fn.substitute(vim.fn.FugitiveGitDir(), '.git', '', '')

  diffview.open(hash, "-C"..git_dir)
end
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
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', '<leader>ghk', gs.preview_hunk)
    map('n', '<leader>ghj', gs.next_hunk)

    map('n', '<leader>ghs', gs.stage_hunk)
    map('v', '<leader>ghs', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)

    map('n', '<leader>ghu', gs.undo_stage_hunk)

    map('n', '<leader>ghr', gs.reset_hunk)
    map('v', '<leader>ghr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)

    map('n', '<leader>ghR', gs.reset_buffer)
    map('n', '<leader>ghp', gs.preview_hunk)
    map('n', '<leader>ghb', function() gs.blame_line{full=true} end)
    map('n', '<leader>ghB', gs.toggle_current_line_blame)
    map('n', '<leader>ghd', gs.diffthis)
    map('n', '<leader>ghD', function() gs.diffthis('~') end)
    map('n', '<leader>ghS', gs.stage_buffer)
    map('n', '<leader>ghU', gs.reset_buffer_index)
    map('n', '<leader>gha', gs.setloclist)

    -- Text objects
    map('o', '<leader>ih', gs.select_hunk)
    map('x', '<leader>ih', gs.select_hunk)
  end
}
EOF

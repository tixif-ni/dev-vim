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
  watch_gitdir = {
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

   -- Navigation
   map('n', ']c', function()
     if vim.wo.diff then return ']c' end
     vim.schedule(function() gs.next_hunk() end)
     return '<Ignore>'
   end, {expr=true})

   map('n', '[c', function()
     if vim.wo.diff then return '[c' end
     vim.schedule(function() gs.prev_hunk() end)
     return '<Ignore>'
   end, {expr=true})

   -- Actions
   map('n', '<leader>ghs', gs.stage_hunk)
   map('n', '<leader>ghr', gs.reset_hunk)
   map('v', '<leader>ghs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
   map('v', '<leader>ghr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
   map('n', '<leader>ghS', gs.stage_buffer)
   map('n', '<leader>ghu', gs.undo_stage_hunk)
   map('n', '<leader>ghR', gs.reset_buffer)
   map('n', '<leader>ghp', gs.preview_hunk)
   map('n', '<leader>ghb', function() gs.blame_line{full=true} end)
   map('n', '<leader>gtb', gs.toggle_current_line_blame)
   map('n', '<leader>ghd', gs.diffthis)
   map('n', '<leader>ghD', function() gs.diffthis('~') end)
   map('n', '<leader>gtd', gs.toggle_deleted)

   -- Text object
   map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

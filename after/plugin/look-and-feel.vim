"=============================================================================
" LUALINE
"=============================================================================

lua << EOF
require('lualine').setup {
  options = {
    theme = 'material'
  },
  sections = {
  lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    }
  },
  extensions = { 'nvim-tree', 'quickfix', 'fugitive' }
}
EOF

"=============================================================================
" DIMINACTIVE
"=============================================================================

let g:diminactive_enable_focus = 1

"=============================================================================
" ILLUMINATE
"=============================================================================

hi illuminatedWord cterm=underline gui=underline 

"=============================================================================
" SPELUNKER 
"=============================================================================

" Option to disable word checking.
" Disable URI checking. (default: 0)
let g:spelunker_disable_uri_checking = 1

" Disable email-like words checking. (default: 0)
let g:spelunker_disable_email_checking = 1

"=============================================================================
" COPILOT
"=============================================================================

lua << EOF
  vim.g.copilot_no_tab_map = true
  vim.api.nvim_set_keymap(
    "i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true }
  )
EOF

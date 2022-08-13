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
" LENGTHMATTERS
"=============================================================================

let g:lengthmatters_start_at_column = 88

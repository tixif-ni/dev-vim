nmap <leader>rr <Plug>RestNvim
nmap <leader>rp <Plug>RestNvimPreview

lua << EOF
require"rest-nvim".setup {
  result_split_horizontal = true,
  skip_ssl_verification = true,
}
EOF

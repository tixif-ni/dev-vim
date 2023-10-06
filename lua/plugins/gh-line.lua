vim.cmd([[
  nmap <leader>gy <Plug>(gh-line)
  let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '
]])

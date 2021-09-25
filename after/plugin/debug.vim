highlight DapBreakpoint cterm=standout ctermfg=234 ctermbg=167 gui=standout guifg=#263238 guibg=#cc6666
highlight DapStopped cterm=standout ctermfg=143 ctermbg=167 gui=standout guifg=#263238 guibg=#b5bd68

lua << EOF
local dap = require'dap'

dap.adapters.node2 = {
  name = 'node-debug',
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/.local/share/nvim/dapinstall/jsnode/vscode-node-debug2/out/src/nodeDebug.js' }
}

vim.fn.sign_define('DapBreakpoint', {text='', texthl='DapBreakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='DapStopped', linehl='', numhl=''})

function dap_node_attach()
  dap.run({
    type = 'node2',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**'},
  })
end

require'dapui'.setup()
EOF

nnoremap <leader>du :lua require'dapui'.toggle()<CR>
nnoremap <S-k> :lua require'dap'.step_out()<CR>
nnoremap <S-l> :lua require'dap'.step_into()<CR>
nnoremap <leader>dt :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>dn :lua require'dap'.continue()<CR>
nnoremap <leader>dk :lua require'dap'.up()<CR>
nnoremap <leader>dj :lua require'dap'.down()<CR>
nnoremap <leader>d_ :lua require'dap'.run_last()<CR>
nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR>
nnoremap <leader>d? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({'all'})<CR>

augroup process_attach
    autocmd!
    autocmd FileType javascript,typescript nnoremap <buffer> <leader>da :lua dap_node_attach()<CR>
augroup END

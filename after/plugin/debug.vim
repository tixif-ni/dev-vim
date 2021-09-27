nnoremap <leader>dt :lua require'dapui'.toggle()<CR>
nnoremap <leader>dn :lua require'dap'.continue()<CR>
nnoremap <leader>dN :lua require'dap'.reverse_continue()<CR>
nnoremap <leader>dj :lua require'dap'.step_over()<CR>
nnoremap <leader>dJ :lua require'dap'.step_into()<CR>
nnoremap <leader>dk :lua require'dap'.step_back()<CR>
nnoremap <leader>dK :lua require'dap'.step_out()<CR>
nnoremap <leader>dc :lua require'dap'.run_to_cursor()<CR>
nnoremap <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>dl :lua require'dap'.run_last()<CR>

highlight DapBreakpoint cterm=standout ctermfg=234 ctermbg=167 gui=standout guifg=#263238 guibg=#cc6666
highlight DapStopped cterm=standout ctermfg=143 ctermbg=167 gui=standout guifg=#263238 guibg=#b5bd68

lua << EOF
function pick_process(opts)
  function wrapped()
    local output = vim.fn.system({'ps', 'a'})
    local lines = vim.split(output, '\n')
    local procs = {}
    for _, line in pairs(lines) do
      -- output format
      --    " 107021 pts/4    Ss     0:00 /bin/zsh <args>"
      local parts = vim.fn.split(vim.fn.trim(line), ' \\+')
      local pid = parts[1]
      local name = table.concat({unpack(parts, 5)}, ' ')
      if name:match(opts.pattern) then
        if pid and pid ~= 'PID' then
          pid = tonumber(pid)
            if pid ~= vim.fn.getpid() then
              table.insert(procs, { pid = pid, name = name })
            end
        end
      end
    end
    local label_fn = function(proc)
      return string.format("id=%d name=%s", proc.pid, proc.name)
    end
    local result = require('dap.ui').pick_one_sync(procs, "Select process", label_fn)
    return result and result.pid or nil
  end

  return wrapped
end

local dap = require'dap'
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/.local/share/nvim/dapinstall/jsnode/vscode-node-debug2/out/src/nodeDebug.js' }
}

dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**'},
    pid = pick_process({pattern='[node|nodemon]*--inspect*'}),
  }
}

vim.fn.sign_define('DapBreakpoint', {text='', texthl='DapBreakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='DapStopped', linehl='', numhl=''})

require'dapui'.setup()
EOF

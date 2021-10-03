local G = {}

G.set_git_root = function(opts)
  opts = opts or {}
  if opts.cwd == nil or opts.cwd == '' then 
    opts.cwd = vim.fn.substitute(vim.fn.FugitiveGitDir(), '.git', '', '')
  end

  if opts.cwd == nil or opts.cwd == '' then 
    error 'Not a git repository'
  end

  return opts
end

return G

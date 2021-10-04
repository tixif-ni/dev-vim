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

G.get_git_hash = function(line)
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

  return hash
end

return G

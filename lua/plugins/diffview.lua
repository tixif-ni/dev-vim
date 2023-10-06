vim.cmd([[
  :nnoremap <Leader>gdf :DiffviewFileHistory %<CR>

  augroup git_diffview
    autocmd!
    autocmd Filetype git :nnoremap <buffer> <Leader>dd <cmd>lua diffview_fugitive()<CR>
    autocmd Filetype git :nnoremap <buffer> <Leader>dh <cmd>lua diffview_fugitive("..HEAD")<CR>
    autocmd Filetype fugitiveblame :nnoremap <buffer> <Leader>dd <cmd>lua diffview_fugitive()<CR>
  augroup end
]])

local diffview = require"diffview"
diffview.setup {
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

function diffview_fugitive (rev)
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
  elseif blame_line ~= nil and string.len(blame_line) >= 7 then
    hash = blame_line
  else
    return
  end

  if string.find(hash, " ") then
    hash = vim.fn.substitute(hash, " ", "..", "")
  elseif rev ~= nil then
    hash = hash..rev
  else
    hash = hash.."^!"
  end

  local git_dir = vim.fn.substitute(vim.fn.FugitiveGitDir(), '.git', '', '')

  diffview.open(hash, "-C"..git_dir)
end

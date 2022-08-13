local function directory_grep_string(opts)
  opts.cwd = vim.fn.expand('%:p:h')
  return require'telescope.builtin'.grep_string(opts)
end

local function directory_live_grep(opts)
  opts.cwd = vim.fn.expand('%:p:h')
  return require'telescope.builtin'.live_grep(opts)
end

return require'telescope'.register_extension {
  exports = {
    directory_grep_string = directory_grep_string,
    directory_live_grep = directory_live_grep,
  }
}

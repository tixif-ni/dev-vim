local git_utils = require'utils.git'

local function git_grep_string(opts)
  return require'telescope.builtin'.grep_string(git_utils.set_git_root(opts))
end

return require'telescope'.register_extension {
  exports = {
    git_grep_string = git_grep_string,
  }
}

local git_utils = require'utils.git'

local function git_live_grep(opts)
        print(git_utils.set_git_root(opts))
  return require'telescope.builtin'.live_grep(git_utils.set_git_root(opts))
end

return require'telescope'.register_extension {
  exports = {
    git_live_grep = git_live_grep,
  }
}

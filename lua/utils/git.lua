local G = {}

G.get_git_root = function()
    local current_path = vim.fn.expand("%:p")
    local git_dir = vim.fn.finddir(".git", current_path .. ";")

    return vim.fn.substitute(git_dir, ".git", "", "")
end

G.get_line_hash_range = function(rev)
    local text_util = require("utils.text")
    local line = vim.fn.getline(".")

    local log_line = line:match("[commit|Merge:] ([a-f0-9 ]+)")
    if log_line ~= nil then
        log_line = text_util.trim(log_line)
    end

    local blame_line = line:match("([a-f0-9]+).")
    if blame_line ~= nil then
        blame_line = text_util.trim(blame_line)
    end

    if log_line ~= nil and string.len(log_line) > 7 then
        hash = log_line
    elseif blame_line ~= nil and string.len(blame_line) >= 7 then
        hash = blame_line
    else
        return
    end

    if string.find(hash, " ") then
        return vim.fn.substitute(hash, " ", "..", "")
    elseif rev ~= nil and rev ~= "" then
        return hash .. rev
    else
        return hash .. "^!"
    end
end

return G

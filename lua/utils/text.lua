local M = {}

M.trim = function(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

M.startswith = function(text, prefix)
    return text:find(prefix, 1, true) == 1
end

return M

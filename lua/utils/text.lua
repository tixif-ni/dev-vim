local M = {}

M.trim = function(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

return M

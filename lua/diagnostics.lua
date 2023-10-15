-- Disable text object diagnostic next to each line to avoid overbloating UI
vim.diagnostic.config({ virtual_text = false, virtual_lines = false })

-- Setup icons
local diagnostic_icons = { Error = "✗", Warn = "", Hint = "", Info = " " }
for severity, icon in pairs(diagnostic_icons) do
    local hl = "DiagnosticSign" .. severity
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

vim.keymap.set("n", "<space>", function()
    local virtual_lines = vim.diagnostic.config().virtual_lines

    if type(virtual_lines) == "table" then
        vim.diagnostic.config({ virtual_lines = false })
    else
        vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
    end
end, { noremap = true })

vim.keymap.set("n", "<leader><space>", function()
    local virtual_lines = vim.diagnostic.config().virtual_lines

    if type(virtual_lines) == "table" then
        vim.diagnostic.config({ virtual_lines = false })
    else
        vim.diagnostic.config({ virtual_lines = not virtual_lines })
    end
end, { noremap = true })

-- main module file
--
-- @module PGSQL tools
local M = {}

M.setup = function() end

M.inspect = function()
    local bufnr = vim.api.nvim_get_current_buf()

    -- 1. Get the Headers (Line 1)
    -- nvim_buf_get_lines is 0-indexed, so 0, 1 gets the first line
    local header_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
    if not header_line then
        return
    end

    -- 2. Get the Current Row (under cursor)
    local data_line = vim.api.nvim_get_current_line()

    -- Skip if the cursor is on the header or the separator dashed line
    if data_line == header_line or data_line:match("^[-+| ]+$") then
        vim.notify("Cursor is not on a data row", vim.log.levels.WARN)
        return
    end

    -- 3. Parse Headers and Data
    -- We split by ' | ' to handle the standard psql alignment
    local headers = vim.tbl_map(vim.trim, vim.split(header_line, " | ", { trimempty = true }))
    local values = vim.split(data_line, " | ", { trimempty = true })

    local result = {}
    for i, key in ipairs(headers) do
        local val = values[i] or ""
        val = vim.trim(val)

        -- 4. JSON Heuristic + Formatting
        local success, decoded = pcall(vim.json.decode, val)
        if success then
            result[key] = decoded
        else
            result[key] = val
        end
    end

    -- 4. Use jq to prettify
    --raw-input (-R) isn't needed here if we echo the string safely
    local json_keys = "{" .. table.concat(headers, ",") .. "}"
    local json_payload = vim.json.encode(result)
    local cmd = string.format("echo %s | jq '%s'", vim.fn.shellescape(json_payload), json_keys)
    local pretty = vim.fn.systemlist(cmd)

    -- 5. Create Preview Window
    local out_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(out_buf, "filetype", "json")
    vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, pretty)
    vim.api.nvim_buf_set_option(out_buf, "readonly", true)

    local width = math.ceil(vim.o.columns * 0.7)
    local height = math.ceil(vim.o.lines * 0.7)

    local win = vim.api.nvim_open_win(out_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = (vim.o.lines - height) / 2,
        col = (vim.o.columns - width) / 2,
        border = "rounded",
        title = "PSQL Row",
        title_pos = "center",
        style = "minimal",
    })

    -- Buffer-local mapping to close the preview
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = out_buf, silent = true })

    -- Set an autocommand to close the window when you leave it
    vim.api.nvim_create_autocmd("WinLeave", {
        buffer = out_buf, -- Only trigger for this specific buffer
        once = true, -- Only run once (the window will be gone anyway)
        callback = function()
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
        end,
    })
end

return M

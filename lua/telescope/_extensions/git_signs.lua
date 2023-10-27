local telescope_utils = require("telescope.utils")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local telescope_config = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local gitsign_cache = require("gitsigns.cache").cache
local gitsign_config = require("gitsigns.config").config
local gitsign_actions = require("gitsigns.actions")

local entry_maker = function(entry)
    local text = string.format("Lines %d-%d", entry.start, entry.end_)

    local displayer = entry_display.create({
        separator = "",
        items = {
            { width = 2 },
            { remaining = true },
        },
    })

    local make_display = function()
        local sign = gitsign_config.signs[entry.type]

        return displayer({
            {
                sign.text,
                sign.hl,
            },
            text,
        })
    end

    return {
        value = entry,
        ordinal = text,
        display = make_display,
        lnum = entry.start,
        filename = entry.filename,
    }
end

local generate_new_finder = function()
    local current_buf = vim.api.nvim_get_current_buf()
    local results = {}

    local bcache = gitsign_cache[current_buf]

    if bcache then
        local hunks = bcache.hunks

        for _, hunk in ipairs(hunks) do
            table.insert(results, {
                bufnr = current_buf,
                filename = bcache.file,
                start = hunk.added.start,
                end_ = hunk.vend,
                type = hunk.type,
            })
        end
    end

    if not vim.tbl_isempty(results) then
        return finders.new_table({
            results = results,
            entry_maker = entry_maker,
        })
    end
end

local function git_reset(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)

    current_picker:delete_selection(function(selection)
        local value = selection.value

        local cb = function()
            gitsign_actions.reset_hunk({ value.start, value.end_ })
        end

        vim.api.nvim_buf_call(value.bufnr, cb)
    end)
end

local function git_stage(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)

    current_picker:delete_selection(function(selection)
        local value = selection.value

        local cb = function()
            gitsign_actions.stage_hunk({ value.start, value.end_ })
        end

        vim.api.nvim_buf_call(value.bufnr, cb)
    end)
end

local git_signs = function(opts)
    opts = opts or {}

    local finder = generate_new_finder()

    if finder then
        pickers
            .new(opts, {
                prompt_title = "Git Hunks",
                finder = finder,
                sorter = telescope_config.generic_sorter(opts),
                previewer = telescope_config.grep_previewer(opts),
                attach_mappings = function(prompt_bufnr, map)
                    map("n", "dd", git_reset)
                    map("n", "cc", git_stage)

                    return true
                end,
            })
            :find()
    else
        telescope_utils.notify("git_signs", {
            msg = "No git hunks found",
            level = "INFO",
        })
        return
    end
end

return require("telescope").register_extension({
    exports = {
        git_signs = git_signs,
    },
})

local utils = require("telescope.utils")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")

local entry_maker = function(entry)
    local config = require("gitsigns.config").config

    local displayer = entry_display.create({
        separator = "",
        items = {
            { width = 2 },
            { remaining = true },
        },
    })

    local make_display = function()
        local sign = config.signs[entry.type]

        return displayer({
            {
                sign.text,
                sign.hl,
            },
            entry.text,
        })
    end

    return {
        value = entry,
        ordinal = entry.text,
        display = make_display,
        lnum = entry.lnum,
        filename = entry.filename,
    }
end

local generate_new_finder = function()
    local cache = require("gitsigns.cache").cache

    local current_buf = vim.api.nvim_get_current_buf()
    local results = {}

    local buff_cache = cache[current_buf]

    if buff_cache then
        local hunks = buff_cache.hunks

        for i, hunk in ipairs(hunks) do
            table.insert(results, {
                bufnr = current_buf,
                filename = buff_cache.file,
                lnum = hunk.added.start,
                type = hunk.type,
                text = string.format("Lines %d-%d (%d/%d)", hunk.added.start, hunk.vend, i, #hunks),
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

local git_signs = function(opts)
    opts = opts or {}

    local finder = generate_new_finder()

    if finder then
        pickers
            .new(opts, {
                prompt_title = "Git Hunks",
                finder = finder,
                sorter = conf.generic_sorter(opts),
                -- TODO: Would it be better to use git diff previewer?
                previewer = conf.grep_previewer(opts),
                attach_mappings = function(prompt_bufnr, map)
                    -- TODO: Add mappings to stage | reset hunks
                    return true
                end,
            })
            :find()
    else
        utils.notify("git_signs", {
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

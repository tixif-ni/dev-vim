local telescope_utils = require("telescope.utils")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local cache = require("gitsigns.cache").cache
local config = require("gitsigns.config").config

local entry_maker = function(entry)
    local hunk = entry.hunk
    local text = string.format("Lines %d-%d", hunk.added.start, hunk.vend)

    local displayer = entry_display.create({
        separator = "",
        items = {
            { width = 2 },
            { remaining = true },
        },
    })

    local make_display = function()
        local sign = config.signs[hunk.type]

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
        lnum = hunk.added.start,
        filename = entry.filename,
    }
end

local generate_new_finder = function()
    local current_buf = vim.api.nvim_get_current_buf()
    local results = {}

    local bcache = cache[current_buf]

    if bcache then
        local hunks = bcache.hunks

        for _, hunk in ipairs(hunks) do
            table.insert(results, {
                filename = bcache.file,
                hunk = hunk,
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
                previewer = conf.grep_previewer(opts),
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

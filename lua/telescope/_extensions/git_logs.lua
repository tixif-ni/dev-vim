local pickers = require("telescope.builtin")
local previewers = require("telescope.previewers")
local putils = require("telescope.previewers.utils")
local utils = require("telescope.utils")
local action_state = require("telescope.actions.state")

local git_command = utils.__git_command
local ns_previewer = vim.api.nvim_create_namespace("telescope.previewers")

function git_commit_yank()
    local selection = action_state.get_selected_entry()

    vim.fn.setreg("+", selection.msg)
end

function git_logs_previewer(opts)
    local hl_map = {
        "TelescopeResultsIdentifier",
        "TelescopePreviewUser",
        "TelescopePreviewDate",
    }

    return previewers.new_buffer_previewer({
        title = "Git Logs",
        get_buffer_by_name = function(_, entry)
            return entry.value
        end,

        define_preview = function(self, entry)
            local cmd = git_command({ "--no-pager", "log", "--stat", "-n 1", entry.value }, opts)

            putils.job_maker(cmd, self.state.bufnr, {
                value = entry.value,
                bufname = self.state.bufname,
                cwd = opts.cwd,
                callback = function(bufnr, content)
                    if not content then
                        return
                    end
                    for k, v in ipairs(hl_map) do
                        local _, s = content[k]:find("%s")
                        if s then
                            vim.api.nvim_buf_add_highlight(bufnr, ns_previewer, v, k - 1, s, #content[k])
                        end
                    end
                end,
            })
        end,
    })
end

return require("telescope").register_extension({
    exports = {
        git_logs = function(opts)
            opts = opts or {}
            opts.previewer = {
                git_logs_previewer(opts),
            }

            opts.attach_mappings = function(_, map)
                map("n", "yy", git_commit_yank)
                return true
            end

            pickers.git_commits(opts)
        end,
    },
})

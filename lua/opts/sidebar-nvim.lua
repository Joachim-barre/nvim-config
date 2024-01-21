local M = {}

function M.save_file()
    local builtin = require "telescope.builtin"
    local actions = require "telescope.actions"
    local actions_state = require "telescope.actions.state"

    function enter(prompt_bufnr)
        local selected = actions_state.get_selected_entry()
        local buffer_id = selected.bufnr

       -- Save the buffer with the specified ID
        vim.api.nvim_buf_call(buffer_id, function()
            vim.cmd("write")
        end)

        actions.close(prompt_bufnr)
    end

    local opts = {
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<CR>", enter)
            return true
        end
    }

    builtin.buffers(opts)
end

function M.run_file()
    local builtin = require "telescope.builtin"
    local actions = require "telescope.actions"
    local actions_state = require "telescope.actions.state"

    function enter(prompt_bufnr)
        local selected = actions_state.get_selected_entry()
        local buffer_id = selected.bufnr

        vim.fn.win_gotoid(buffer_id)

        vim.api.nvim_buf_call(buffer_id, function()
            require("code_runner.commands").run_code(vim.bo.filetype)
        end)
 
        actions.close(prompt_bufnr)
    end

    local opts = {
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<CR>", enter)
            return true
        end
    }

    builtin.buffers(opts)
end

function M.config_prompt(opts)
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values
    local previewers = require "telescope.previewers"

    opts = opts or {}

    files = {
        vim.fn.expand("~/.config/nvim/defaults-configs/toggletasks.json"),
        vim.fn.expand("./.nvim/toggletasks.json"),
        vim.fn.expand("./.nvim/project.json"),
        vim.fn.expand("./.nvim/run.json"),
        vim.fn.expand("./.nvim/lspconfig.json"),
        vim.fn.expand("./.nvim/local.vim"),
        vim.fn.expand("./.nvim/local-conf.lua"),
    }
    pickers.new(opts, {
        prompt_title = "config",
        finder = finders.new_table {
            results = files
        },
        sorter = conf.file_sorter(opts),
        previewer = previewers.cat.new({
            title = "current config",
        })
    }):find()
end

local sidebar = require("sidebar-nvim")
on_clicked = function(line, col)
    if shown then
        if line == 0 then
            shown = false
        elseif line == 1 then
            vim.cmd('NvimTreeToggle')
        elseif line == 2 then
            local command = ":tabnew " 
            command = command .. vim.fn['quickui#input#open']('file to open:')
            vim.cmd(command)
        elseif line == 3 then
            M.save_file()
        elseif line == 4 then
            vim.cmd(':wa')
        elseif line == 5 then 
            M.run_file()
        elseif line == 6 then
            vim.cmd('Telescope toggletasks spawn')
        elseif line == 7 then
            vim.cmd('tab term sleep 1 && gitui')
        elseif line == 8 then
            M.config_prompt()
        elseif line == 9 then
            vim.cmd("ToggleTerm")
        elseif line == 10 then
            vim.cmd(':qa')
        end
    else
        if line == 0 then
            shown = true
        end
    end
end
local section = {
    shown = false,
    title = "Actions",
    icon = ">",
    setup = function(ctx)
        -- called only once and if the section is being used
    end,
    update = function(ctx)
        -- hook callback, called when an update was requested by either the user of external events (using autocommands)
    end,
    draw = function(ctx)
        if shown then
            return {
                lines = {
                    "󰁙 enter to hide",
                    " file explorer",
                    " open file",
                    " save file",
                    " save all files",
                    " run file",
                    " execute task",
                    "󰊢 gitui",
                    " open configs",
                    " terminal",
                    "󰗼 exit all",
                },
                hl={}
            }
        else
            return "󰁊 enter to show"
        end
    end,
    bindings = {
        ["e"] = on_clicked;
        ["<CR>"] = on_clicked;
    },
}
local opts = {
    open = true,
    datetime = {
        icon = "󰥔",
        format = "%a %b %d, %H:%M",
        clocks = {
            { name = "local" }
        }
    },
    sections = {"datetime", section, "files", "git" ,"diagnostics"} ,
}

return opts

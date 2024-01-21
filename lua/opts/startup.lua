local opts = require("startup.themes.dashboard")
opts.info = {
    type='text',
    oldfiles_directory = false, -- if the oldfiles of the current directory should be displayed
    align = "center", -- "center", "left" or "right"
    fold_section = false, -- whether to fold or not
    title = "time", -- title for the folded section
    margin = 5, -- the margin for left or right alignment
    content = function()
        local clock = " " .. os.date "%H:%M" .. "    " .. os.date "%d/%m/%y"
        return {clock,date}
    end,
    highlight = "String",
    default_color = "",
    oldfiles_amount = 0,
}
opts.body.content = {
    { " Find File", "Telescope find_files", "<leader>ff" },
    { " Find Word", "Telescope live_grep", "<leader>lg" },
    { " Recent Files", "Telescope oldfiles", "<leader>of" },
    { "󰺏 Resume session", "SessionManager load_last_session", "<leader>rs"},
    { "󱛡 Load old session", "SessionManager load_session", "<leader>ls"},
    { " File Browser", "NvimTreeToggle", "<leader>fb" },
    { " Colorschemes", "Telescope colorscheme", "<leader>cs" },
    { " New File", "lua require'startup'.new_file()", "<leader>nf"}
}
opts.parts = { "header", "info", "body", "footer" }

return opts

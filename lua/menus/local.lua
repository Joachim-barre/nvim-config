menu = require "menus.default"

menu[6] =  {
    name = "Edit Profile",
    cmd = function()
        vim.cmd "tabnew"
        vim.cmd "e .nvim/profile.json"
    end,
    rtxt = "ed",
}

return menu

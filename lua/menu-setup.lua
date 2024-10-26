function setup()
    -- Keyboard users
    vim.keymap.set("n", "<C-e>", function()
      require("menu").open("local")
    end, {})

    -- mouse users + nvimtree users!
    vim.keymap.set("n", "<RightMouse>", function()
      vim.cmd.exec '"normal! \\<RightMouse>"'

      local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
      require("menu").open("local", { mouse = true })
    end, {})
end

return {
    setup = setup
}

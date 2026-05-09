hop = require("hop")

vim.keymap.set("n", "f", function()
    hop.hint_words()
end)

vim.keymap.set("n", "w", function()
    hop.hint_lines({ multi_windows = true })
end)

return {
    uppercase_labels = true,
}

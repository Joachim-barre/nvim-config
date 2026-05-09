hop = require("hop")

vim.keymap.set("n", "f", function()
    hop.hint_words()
end)

return {
    uppercase_labels = true,
}

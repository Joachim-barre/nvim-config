opts = {
    mode="toggleterm",
    float = {
        border = "rounded",
    }
}
local project_path = vim.fn.expand("./.nvim/project.json")
if vim.fn.filereadable(project_path) == 1 then
    opts.project_path = project_path
end
opts.filetype = vim.g.profile.run

vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })

return opts

opts = {
    mode="tab",
    float = {
        border = "rounded",
    }
}
local project_path = vim.fn.expand("./.nvim/project.json")
if vim.fn.filereadable(project_path) == 1 then
    opts.project_path = project_path
end
local filetype_path = vim.fn.expand("./.nvim/run.json")
filetype_default = {
    java = {
        "cd $dir &&",
        "javac $fileName &&",
        "java $fileNameWithoutExt"
    },
    python = 'python3 $file $end',
    sh = "zsh",
    c = {
        "cd $dir &&",
        "clang $fileName",
        "-o $fileNameWithoutExt &&",
        "$dir/$fileNameWithoutExt",
    },
    cpp = {
        "cd $dir &&",
        "clang $fileName",
        "-o $fileNameWithoutExt &&",
        "$dir/$fileNameWithoutExt",
    },
    rust = "cargo test && cargo run $end"
}
if vim.fn.filereadable(filetype_path) == 1 then
    filetype = require("code_runner.load_json")(filetype_path)
else
    filetype = {}
end
for k,v in pairs(filetype) do filetype_default[k] = v end
opts.filetype = filetype_default

vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })

return opts

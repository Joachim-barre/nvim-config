safe_setup = require "safe_require".safe_setup
safe_require = require "safe_require".safe_require
modules = {
    "rocks-setup",
    "sidebar-nvim",
    "nvim-tree",
    "bufferline",
    "toggletasks",
    "toggleterm",
    "startup",
    "telescope",
    "symbols-outline",
    "code_runner",
    "session-setup",
    "welcome-setup",
    "statusline-setup",
    "lsp-setup",
    'nvim-treesitter.configs',
    "dap-config",
    "dapui",
    "quickgd",
    "mason",
    "mason-lspconfig",
    'mini.clue',
    'venv-selector',
    'glow',
    'headlines',
    'cmp'
}
for i, module in ipairs(modules) do
    safe_setup(module)
end

local_path = vim.fn.expand("./.nvim/local-conf.lua") 
if vim.fn.filereadable(local_path) then
    package.path = './.nvim/?.lua;' .. package.path 
    safe_require("local-conf")
end

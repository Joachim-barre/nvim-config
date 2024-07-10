local M = {}

M.modules = {
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
    'cmp',
    'gitsigns',
    'mini.git',
    'render-markdown'
}

function build_modulelist()
    local table1 = M.modules
    local table2 = vim.g.profile.disabled_modules
    -- https://stackoverflow.com/a/64590508
    for number = 1, #table1 do
        for delete = 1, #table2 do
            if table1[number] == table2[delete] then
                for i = number,  #table1 -1 do
                    table1[i] = table1[i +1]
                end  --  shuffle every entry in table down
                table1 [#table1] = nil  --  erase last entry
            end  --  number == delete
        end  --  loop through table2
    end  --  loop through table1
    return table1
end

function apply_profile() 
    local profile = vim.g.profile
    profile.modules = build_modulelist()
    vim.g.profile = profile
end

function M.load_default()
    vim.g.profile = require("code_runner.load_json")(vim.fn.stdpath("config") .. "/defaults-configs/profile.json")
    if vim.g.profile == nil then
        vim.notify("cloud not parse default profile")
        return nil
    end
    apply_profile()
    return vim.g.profile
end

function M.load()
    return M.load_default()
end

return M

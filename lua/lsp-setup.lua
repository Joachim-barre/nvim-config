local M = {}

M.configname_to_lspname = {
    ["pyright"] = "pyright",
    ["clangd"] = "clangd",
    ["csharp"] = "omnisharp",
    ["cmp"] = "",
    ["rust"] = "rust_analyzer",
    ["asm"] = "asm-lsp",
}

function M.setup()
    local config = vim.g.profile["lspconfig"] or {}
    vim.cmd([[
    augroup _cpp_module
    autocmd!
    autocmd BufRead,BufEnter *.mxx set filetype=cpp
    autocmd BufRead,BufEnter *.cppm set filetype=cpp
    autocmd BufRead,BufEnter *.ixx set filetype=cpp
    augroup end
    ]])
    local protocol = require('vim.lsp.protocol')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.lsp.config("pyright", {
        capabilities= capabilities
    })
    vim.lsp.config("clangd", {
        capabilities= capabilities
    })    
    vim.lsp.config("omnisharp", {
        capabilities = capabilities,
        cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
        root_dir = function ()
            return vim.loop.cwd() -- current working directory
        end,
    })
    vim.lsp.config("rust_analyzer", {
        capabilities=capabilities
    })
    if config.cmp then
        vim.cmd([[
        highlight Pmenu ctermbg=gray guibg=gray
        ]])
    end

    for k, v in pairs(config) do
        local name = M.configname_to_lspname[k]
        if (not (name == "")) and v.enabled then
            if not (v.config == nil) then
                vim.lsp.config(name, v.config)
            end

            vim.lsp.enable(name)
        end
    end

    vim.diagnostic.config({ 
        virtual_text = true,
        severity_sort = true
    })

    vim.o.updatetime = 250

    vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
            vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = '',
            scope = 'cursor',
        })
    end
    })

    vim.cmd("autocmd VimEnter * hi NormalFloat guibg=dark")

end

return M

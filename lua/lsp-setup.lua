local M = {}

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

    vim.lsp.config("omnisharp", {
        cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
        root_dir = function ()
            return vim.loop.cwd() -- current working directory
        end,
    })
    if config.cmp then
        vim.cmd([[
        highlight Pmenu ctermbg=gray guibg=gray
        ]])
    end

    for name, v in pairs(config) do
        if (not (name == "cmp")) and v.enabled then
            vim.lsp.config(name, {
                capabilities= capabilities
            })
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

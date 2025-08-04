local M = {}

function M.setup()
    local config_path = vim.fn.expand("./.nvim/lspconfig.json")
    local config = {}
    if vim.fn.filereadable(config_path) == 1 then
        config = require("code_runner.load_json")(config_path)
    end
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

    config_def = {
        pyright = true,
        clangd = true,
        csharp = true,
        rust = true,
        cmp = true,
    }
    for k,v in pairs(config) do config_def[k] = v end
    config = config_def
    vim.lsp.config("pyright", {
        capabilities= capabilities
    })
    vim.lsp.config("clangd", {
        capabilities= capabilities
    })    
    vim.lsp.config("omnisharp", {
        capabilities = capabilities,
        cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
        settings = {
        omnisharp = {
                enableImportCompletion = true,
                organizeImportsOnFormat = true,
                enableRoslynAnalyzers = true,
            }
        },
        root_dir = function ()
            return vim.loop.cwd() -- current working directory
        end,
    })
    vim.lsp.config("rust-analyser", {
        capabilities=capabilities
    })
    if config.cmp then
        vim.cmd([[
        highlight Pmenu ctermbg=gray guibg=gray
        ]])
    end

    for k, v in pairs(config) do
        if v then
            vim.lsp.enable("k")
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

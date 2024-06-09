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
    local coq = require "coq"

    config_def = {
        pyright = true,
        clangd = true,
        csharp = true,
        rust = true,
        cmp = true,
    }
    for k,v in pairs(config) do config_def[k] = v end
    config = config_def
    if config.pyright then
        require'lspconfig'.pyright.setup{coq.lsp_ensure_capabilities()}
    end
    if config.clangd then 
        require("lspconfig").clangd.setup(
            coq.lsp_ensure_capabilities({
                on_attach = function()
                -- do stuff here....
        end
        }))
    end
    if config.csharp then
            require("lspconfig").omnisharp.setup {
                capabilities = capabilities,
                cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
                enable_import_completion = true,
                organize_imports_on_format = true,
                enable_roslyn_analyzers = true,
                root_dir = function ()
                    return vim.loop.cwd() -- current working directory
                end,
            }
    end
    if config.rust then
        require('lspconfig').rust_analyzer.setup{

        }
    end
    if config.cmp then
        vim.cmd([[
        augroup COQ 
        autocmd!
        autocmd VimEnter * COQnow -s
        augroup END
        highlight Pmenu ctermbg=gray guibg=gray
        ]])
    end
end
return M

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

    for name, v in pairs(config) do
        if v.enabled then
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


--- https://www.reddit.com/r/neovim/comments/1kzdd5x/restartlsp_but_for_native_vimlsp/
local current_buffer_bfnr = 0

M.buf_restart_clients = function()
    local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr or current_buffer_bfnr })
	vim.lsp.stop_client(clients, true)

	local timer = vim.uv.new_timer()

	timer:start(500, 0, function()
		for _, _client in ipairs(clients) do
			vim.schedule_wrap(function(client)
				vim.lsp.enable(client.name)

				vim.cmd(":noautocmd write")
				vim.cmd(":edit")
			end)(_client)
		end
	end)
end

vim.api.nvim_create_user_command("LspRestart",
function(opts)
    M.buf_restart_clients()
end, {nargs=0})

return M

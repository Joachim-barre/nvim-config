local M = {
    xmake_component = {
        function()
            local xmake = require("xmake.project_config").info
            if xmake.target.tg == "" then
                return ""
            end
            return xmake.target.tg .. "(" .. xmake.mode .. ")"
        end,

        cond = function()
            return vim.o.columns > 100
        end,

        on_click = function()
            require("xmake.project_config._menu").init() -- Add the on-click ui
        end,
    }
}

function M.setup()
    opts = {
        options = {
            theme = "powerline_dark",
        },
        
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename', M.xmake_component},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
        extentions="symbols-outline"
    }
    require("lualine").setup(opts)    
end

return M

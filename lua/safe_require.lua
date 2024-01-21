local M = {}

function M.safe_require(module_name)
    local status_ok, module = pcall(require, module_name)
    if not status_ok then
        if not silent then
            vim.notify("Couldn't load module '" .. module_name .. "'")
        end
        do return end
    end
    return module
end

function M.get_opts(module_name)
    local status_ok, module = pcall(require, "opts." .. module_name)
    if not status_ok then
        -- vim.notify("Coudn't find opts for '" .. module_name .. "'")
        do return end
    end
    return module
end

function M.safe_setup(module_name)
    module = M.safe_require(module_name)
    opts = M.get_opts(module_name)
    if not (module == null) then
        if opts ~= null then
            if not pcall(module.setup, opts) then
                vim.notify("Coudn't setup module '" .. module_name .. "'")
            end
        else
            if not pcall(module.setup) then
                vim.notify("Coudn't setup module '" .. module_name .. "'")
            end
        end
    end
end

return M

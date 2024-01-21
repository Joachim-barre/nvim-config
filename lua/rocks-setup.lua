local M = {}
local nvim_rocks = require'nvim_rocks'

function M.setup()
    nvim_rocks.ensure_installed("loadkit")
    loadkit = require('loadkit')
    loadkit.register("json", function(file)
        return require("code_runner.load_json")(config_path)	
    end)
end

return M

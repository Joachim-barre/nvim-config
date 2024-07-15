safe_setup = require "safe_require".safe_setup
safe_require = require "safe_require".safe_require 

local status, profile = pcall(require("profile-loader").load)

if not status then
    vim.notify("failed to load profile")
    local profile = require("profile-loader").load_default()
end

if profile["local-scripts"] ~= nil then
    for i, script in ipairs(profile["local-scripts"]) do
        local status = pcall(vim.cmd, "source .nvim/" .. script)
        if not status then
            vim.notify("failed to load local module at .nvim/" .. script)
        end
    end
end

for i, module in ipairs(profile.modules) do
    safe_setup(module)
end

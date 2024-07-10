safe_setup = require "safe_require".safe_setup
safe_require = require "safe_require".safe_require 
local status, profile = pcall(require("profile-loader").load)
if not status then
vim.notify("failed to load profile")
local profile = require("profile-loader").load_default()
end 
for i, module in ipairs(profile.modules) do
    safe_setup(module)
end

local_path = vim.fn.expand("./.nvim/local-conf.lua") 
if vim.fn.filereadable(local_path) then
    package.path = './.nvim/?.lua;' .. package.path 
    safe_require("local-conf")
end

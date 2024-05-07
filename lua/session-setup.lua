local M = {}

function M.setup()
    local config_group = vim.api.nvim_create_augroup('SessionConfigGroup', {})
    local Path = require('plenary.path')
    local config = require('session_manager.config')
    require('session_manager').setup({
        autoload_mode = config.AutoloadMode.Disabled  
    })
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      group = config_group,
      callback = function ()
        if vim.bo.filetype ~= 'git'
          and not vim.bo.filetype ~= 'gitcommit'
          and not vim.bo.filetype ~= 'gitrebase'
          then 
              vim.g.sidebar=require("sidebar-nvim.lib").is_open()
              require('session_manager').autosave_session()
          end
      end
    })
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = "SessionSavePost",
      group = config_group,
      callback = function()
          if vim.g.sidebar then require('sidebar-nvim').open() end
      end,
    })
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = "SessionLoadPost",
      group = config_group,
      callback = function()
        if vim.g.sidebar then require('sidebar-nvim').open() end
      end,
    })
end

return M

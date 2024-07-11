local config_group = vim.api.nvim_create_augroup('SessionConfigGroup', {})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = config_group,
  callback = function ()
    if vim.bo.filetype ~= 'git'
      and not vim.bo.filetype ~= 'gitcommit'
      and not vim.bo.filetype ~= 'gitrebase'
      then 
          require('possession.session').autosave()
      end
  end
})

require('telescope').load_extension('possession')

return {
    autosave = {
        current = true,  -- or fun(name): boolean
        cwd = true, -- or fun(): boolean
        tmp = true,  -- or fun(): boolean
        tmp_name = 'tmp', -- or fun(): string
        on_load = false,
        on_quit = false,
    },
    plugins = {
        close_windows = false,
        delete_hidden_buffers = false
    }
}
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

function on_save(name)
    local userdata = {}

    return userdata
end

function on_load(name, userdata)
    if vim.g.profile.sidebar.enabled ~= 0 then
        require("sidebar-nvim").open()
    end
end

require('telescope').load_extension('possession')

return {
    silent = true,
    debug = false,
    autosave = {
        current = true,  -- or fun(name): boolean
        cwd = true, -- or fun(): boolean
        tmp = true,  -- or fun(): boolean
        tmp_name = 'tmp', -- or fun(): string
        on_load = false,
        on_quit = false,
    },
    hooks = {
        before_save = on_save,
        after_load = on_load
    },
    prompt_no_cr = true,
    plugins = {
        close_windows = false,
        delete_hidden_buffers = false
    }
}

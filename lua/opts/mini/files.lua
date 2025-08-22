local minifiles_toggle = function(...)
    if not MiniFiles.close() then MiniFiles.open(...) end
end

vim.keymap.set('n', '<leader>f', function()
    minifiles_toggle(vim.api.nvim_buf_get_name(0))
end, {desc="toggle mini.files"})

return {
    mappings = {
        close       = '<Esc>',
        go_in       = '<Right>',
        go_in_plus  = '<Enter>',
        go_out      = '<Left>',
        go_out_plus = 'H',
        mark_goto   = "'",
        mark_set    = 'm',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = 'w',
    },
}

 vim.cmd([[

augroup BufferLineColor

autocmd!

autocmd VimEnter * highlight TabLineFill gui=None

autocmd VimEnter * highlight BufferLineFill guibg=#191724

autocmd VimEnter * highlight BufferLineSeparator guifg=#191724

autocmd VimEnter * highlight BufferLineSeparatorSelected guifg=#191724

augroup END

]]) 

return {
    options = {
        diagnostics = "nvim_lsp",
        offsets = {
            {
                    filetype = "SidebarNvim",
                    text = "Sidebar" ,
                    text_align = "center",
            }
        },
        close_command = function(bufnum)
            require('bufdelete').bufdelete(bufnum, true)
        end,
        name_formatter = function(buf)
            local parent = vim.fn.fnamemodify(buf.path, ":h:t")
            local filename = vim.fn.fnamemodify(buf.path, ":t")

            if parent == "" then
                return filename
            elseif vim.fn.fnamemodify(buf.path, ":.:h")=="." then
                parent = "."
            end

            return parent .. "/" .. filename
        end,
        sort_by = "relative_directory",
        separator_style="slant"
    }
}


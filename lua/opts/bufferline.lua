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
        end
    }
}


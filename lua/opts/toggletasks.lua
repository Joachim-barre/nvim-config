return {
        -- Directories to consider when searching for available tasks for current window
        scan = {
            global_cwd = true,    -- vim.fn.getcwd(-1, -1)
            tab_cwd = false,       -- vim.fn.getcwd(-1, tab)
            win_cwd = false,       -- vim.fn.getcwd(win)
            lsp_root = false,      -- root_dir for first LSP available for the buffer
            dirs = {
                vim.fn.expand("~/.config/nvim/defaults-configs/"),
                ".nvim/",
            },            -- explicit list of directories to search or function(win): dirs
            rtp = false,          -- scan directories in &runtimepath
            rtp_ftplugin = false, -- scan in &rtp by filetype, e.g. ftplugin/c/toggletasks.json
        }
    }


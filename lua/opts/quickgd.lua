vim.filetype.add {
    extension = {
        gdshaderinc = "gdshaderinc",
    },
}

return   {
    -- Sets the path of your Godot executable.    
    -- Will look for path in GODOT environment variable if not set.
    godot_path = vim.fn.system("/usr/bin/which godot-mono", true),
    -- If opened in project root folder path will already be set
    -- If set to false will use internal selector.
    telescope = true,
    -- Enables GLSL treesitter for gdshader / gdshaderinc. 
    treesitter = true, -- optional: needed for cmp
    -- Disable if you don't want the autocompletion.
    cmp = true, -- optional
}


cmp = require("cmp")

cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline({
    ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
    ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
}),
sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp_document_symbol' },
}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline({
    ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
    ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
}),
sources = {
    { name = 'path' },
    { name = 'cmdline' }
},
matching = { disallow_symbol_nonprefix_matching = false }
})

vim.opt.completeopt = "menu,menuone"

vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#131313" })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#FFFFFF", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#FFFFFF", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#FFFFFF", bg = "#B5585F" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#FFFFFF", bg = "#6d8b41" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#FFFFFF", bg = "#6d8b41" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#FFFFFF", bg = "#6d8b41" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFFFFF", bg = "#cccc00" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFFFFF", bg = "#cccc00" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFFFFF", bg = "#cccc00" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#FFFFFF", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#FFFFFF", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#FFFFFF", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#FFFFFF", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#FFFFFF", bg = "#A377BF" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#FFFFFF", bg = "#7E8294" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#FFFFFF", bg = "#7E8294" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#FFFFFF", bg = "#cc9900" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#FFFFFF", bg = "#cc9900" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#FFFFFF", bg = "#cc9900" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#FFFFFF", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#FFFFFF", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#FFFFFF", bg = "#6C8ED4" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#FFFFFF", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#FFFFFF", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#FFFFFF", bg = "#58B5A8" })


return {
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
        end,
    },
    window = {
        completion = {
            winhighlight = "Normal:CmpNormal",
            col_offset = -3,
            side_padding = 0,
        }
    },
    mapping = cmp.mapping.preset.insert({
      ['<S-Down>'] = cmp.mapping.scroll_docs(-4),
      ['<S-Up>'] = cmp.mapping.scroll_docs(4),
      ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
      ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
      ['<S-Esc>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
        { name = 'buffer' },
        { name = 'calc' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' } 
    }
}

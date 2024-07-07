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

return {
    mapping = cmp.mapping.preset.insert({
      ['<S-Down>'] = cmp.mapping.scroll_docs(-4),
      ['<S-Up>'] = cmp.mapping.scroll_docs(4),
      ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
      ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
      ['<Esc>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
        { name = 'buffer' },
        { name = 'calc' },
        { name = 'nvim_lsp' },
    }
}

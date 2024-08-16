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
    formatting = {
        format = require("lspkind").cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                           -- can also be a function to dynamically calculate max width such as 
                           -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (entry, vim_item)
                return vim_item
            end
        })
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

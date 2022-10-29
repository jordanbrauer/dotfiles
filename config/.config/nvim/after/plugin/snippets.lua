-- If you want to use snippet for multiple filetypes, you can
-- `g:vsnip_filetypes` for it.
vim.g.vsnip_filetypes = {}
vim.g.vsnip_filetypes.javascriptreact = { 'javascript' }
vim.g.vsnip_filetypes.typescriptreact = { 'typescript' }

-- Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
-- See https://github.com/hrsh7th/vim-vsnip/pull/50
-- vim.keymap.set({'n', 'x'}, 's', '<Plug>(vsnip-select-text)')
-- vim.keymap.set({'n', 'x'}, 'S', '<Plug>(vsnip-cut-text)')

-- Expand
vim.keymap.set(
    { 'i', 's' },
    '<C-j>',
    "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'",
    {
        expr = true,
    })

-- Expand or jump
vim.keymap.set(
    { 'i', 's' },
    '<C-l>',
    "vsnip#available(1) ? 'echo <Plug>(vsnip-expand-or-jump)' : 'echo <C-l>'",
    {
        expr = true,
    })

-- Jump forward or backward
vim.keymap.set(
    { 'i', 's' },
    '<Tab>',
    "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
    {
        expr = true,
    })
vim.keymap.set(
    { 'i', 's' },
    '<S-Tab>',
    "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
    {
        expr = true,
    })

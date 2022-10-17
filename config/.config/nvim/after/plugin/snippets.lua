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
    function()
        if vim.cmd [[ exe vsnip#expandable() ]] then
            return '<Plug>(vsnip-expand)'
        end

        return '<C-j>'
    end,
    {
        expr = true,
    })

-- Expand or jump
vim.keymap.set(
    { 'i', 's' },
    '<C-l>',
    function()
        if vim.cmd [[ exe vsnip#available(1) ]] then
            return '<Plug>(vsnip-expand-or-jump)'
        end

        return '<C-l>'
    end,
    {
        expr = true,
    })

-- Jump forward or backward
vim.keymap.set(
    { 'i', 's' },
    '<Tab>',
    function()
        if vim.cmd [[ exe vsnip#jumpable(1) ]] then
            return '<Plug>(vsnip-jump-next)'
        end

        return '<Tab>'
    end,
    {
        expr = true,
    })

vim.keymap.set(
    { 'i', 's' },
    '<S-Tab>',
    function()
        if vim.cmd [[ exe vsnip#jumpable(-1) ]] then
            return '<Plug>(vsnip-jump-prev)'
        end

        return '<S-Tab>'
    end,
    {
        expr = true,
    })

-- Include .mdx files as Markdown
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.mdx' },
    group = 'editor_behaviour',
    callback = function() vim.opt.syntax = 'markdown' end,
})

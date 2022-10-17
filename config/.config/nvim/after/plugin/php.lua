local lsp = require('lsp')

lsp.setup('intelephense')

-- Use # as comment symbol for PHP files
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'php' },
    group = 'editor_behaviour',
    callback = function() vim.opt_local.commentstring = "# %s" end,
})

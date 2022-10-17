local lsp = require('lsp')
local go = require('go')
local format = require('go.format')

lsp.setup('gopls')
go.setup()

-- Format Go files on save
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*.go' },
    group = 'editor_behaviour',
    callback = format.goimport,
})

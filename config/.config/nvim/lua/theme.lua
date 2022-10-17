local protocol = require('vim.lsp.protocol')
local lualine = require('lualine')
local citylights = require('lualine.themes.citylights')

require('colorizer').setup() -- hexcode, rgb, etc.
require('colorbuddy').colorscheme('citylights')
lualine.setup(citylights)

vim.fn.sign_define('DiagnosticSignError', { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define('DiagnosticSignWarn', { text = "", texthl = "DiagnosticWarn" })
vim.fn.sign_define('DiagnosticSignInfo', { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define('DiagnosticSignHint', { text = "", texthl = "DiagnosticHint" })

-- Disable the colorcolumn for file browser
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = {'netrw'},
    group = 'editor_behaviour',
    callback = function() vim.opt_local.colorcolumn = nil end,
})

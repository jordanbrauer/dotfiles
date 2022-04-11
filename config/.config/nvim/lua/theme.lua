local protocol = require('vim.lsp.protocol')
local lualine = require('lualine')
local citylights = require('lualine.themes.citylights')

require('colorbuddy').colorscheme('citylights')
lualine.setup(citylights)

vim.fn.sign_define('DiagnosticSignError', { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define('DiagnosticSignWarn', { text = "", texthl = "DiagnosticWarn" })
vim.fn.sign_define('DiagnosticSignInfo', { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define('DiagnosticSignHint', { text = "", texthl = "DiagnosticHint" })

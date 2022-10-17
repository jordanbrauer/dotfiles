local theme = {
    completion = {
        icons = {
            Text = '',
            Method = 'λ',
            Function = 'λ',
            Constructor = '𝑓',
            Field = '',
            Variable = '',
            Class = '',
            Interface = 'ﰮ',
            Module = '',
            Property = '',
            Unit = '',
            Value = '',
            Enum = '',
            Keyword = '',
            Snippet = '',
            Color = '',
            File = '',
            Reference = '',
            Folder = '',
            EnumMember = '',
            Constant = 'π',
            Struct = '',
            Event = '',
            Operator = '',
            TypeParameter = '',

            DiagnosticError = "",
            DiagnosticWarn = "",
            DiagnosticInfo = "",
            DiagnosticHint = "",
        },
        sources = {
            buffer = "Buffer",
            nvim_lsp = "LSP",
            vsnip = "Snippet",
        }
    }
}

function theme.configure()
    local lualine = require('lualine')
    local citylights = require('lualine.themes.citylights')
    local icons = theme.completion.icons

    require('colorizer').setup() -- hexcode, rgb, etc.
    require('colorbuddy').colorscheme('citylights')
    lualine.setup(citylights)

    vim.fn.sign_define('DiagnosticSignError', { text = icons.DiagnosticError, texthl = "DiagnosticError" })
    vim.fn.sign_define('DiagnosticSignWarn', { text = icons.DiagnosticWarn, texthl = "DiagnosticWarn" })
    vim.fn.sign_define('DiagnosticSignInfo', { text = icons.DiagnosticInfo, texthl = "DiagnosticInfo" })
    vim.fn.sign_define('DiagnosticSignHint', { text = icons.DiagnosticHint, texthl = "DiagnosticHint" })

    -- Disable the colorcolumn for file browser
    vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = {'netrw'},
        group = 'editor_behaviour',
        callback = function() vim.opt_local.colorcolumn = nil end,
    })
end

function theme.completion_item(entry, vim_item)
    local icons = theme.completion.icons
    local sources = theme.completion.sources

    vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)
    vim_item.menu = string.format('[%s]', sources[entry.source.name] or '???')

    return vim_item
end

return theme

require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
        custom_captures = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    ensure_installed = {
        "php", "typescript", "go", "gomod", "graphql", "javascript"
    },
}

-- Show (non-Treesitter) syntax highlighting groups for word under cursor.
vim.keymap.set(
    'n',
    'gm',
    function()
        local selected = vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 1)
        local child = vim.fn.synIDattr(selected, 'name')
        local parent = vim.fn.synIDattr(vim.fn.synIDtrans(selected), 'name')

        print(string.format('Syntax Group: %s → %s', child, parent))
    end)

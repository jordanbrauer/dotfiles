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

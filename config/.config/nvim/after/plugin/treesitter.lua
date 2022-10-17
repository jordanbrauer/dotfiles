require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false, -- or list of configs; {'go'}
    },
    indent = {
        enable = true,
        disable = {},
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    ensure_installed = {
        "php",
        "go",
        "gomod",
        "elixir",
        "graphql",
        "javascript",
        "typescript",
    },
}

-- HACK: This autocommand is a hack to fix an issue with opening files via
-- Telescope find_files missing folds until the file is written with `:e`.
--
-- See https://github.com/nvim-telescope/telescope.nvim/issues/699 for details.
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    group = 'editor_behaviour',
    pattern = { '*' },
    command = 'normal zR',
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileReadPost' }, {
    group = 'editor_behaviour',
    pattern = { '*' },
    command = 'normal zx'
})

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

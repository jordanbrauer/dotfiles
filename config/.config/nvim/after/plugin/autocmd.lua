vim.api.nvim_create_augroup('editor_behaviour', { clear = true })
vim.api.nvim_create_augroup('packer_user_config', { clear = true })

-- Re-Compile Packer when plugins file is written
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = { 'plugins.lua' },
    group = 'packer_user_config',
    callback = function()
        local file = vim.cmd [[ silent! echo expand("%") ]]

        vim.api.nvim_command('source ' .. file .. ' | PackerCompile')
    end,
})

-- Automatically put user into INSERT mode upon terminal opening
vim.api.nvim_create_autocmd({'TermOpen'}, {
    pattern = {'*'},
    group = 'editor_behaviour',
    callback = function()
        vim.cmd [[ startinsert ]]
    end,
})

-- Disable editorconfig for git commits
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = {'gitcommit'},
    group = 'editor_behaviour',
    callback = function()
        vim.cmd [[ let b:EditorConfig_disable = 1 ]]
    end,
})

-- Disable the colorcolumn for file browser
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = {'netrw'},
    group = 'editor_behaviour',
    callback = function()
        vim.opt_local.colorcolumn = nil
    end,
})

-- Format Go files on save
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*.go' },
    group = 'editor_behaviour',
    callback = function()
        require('go.format').goimport()
    end,
})

-- Use # as comment symbol for PHP files
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'php' },
    group = 'editor_behaviour',
    callback = function ()
        vim.opt_local.commentstring = "# %s"
    end,
})

-- Include .mdx files as Markdown
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.mdx' },
    group = 'editor_behaviour',
    callback = function()
        vim.opt.syntax = 'markdown'
    end,
})

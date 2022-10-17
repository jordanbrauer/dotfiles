vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' }

-- Disable editorconfig for git commits
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = {'gitcommit'},
    group = 'editor_behaviour',
    callback = function()
        vim.cmd [[ let b:EditorConfig_disable = 1 ]]
    end,
})

-- Automatically put user into INSERT mode upon terminal opening
vim.api.nvim_create_autocmd({'TermOpen'}, {
    pattern = {'*'},
    group = 'editor_behaviour',
    callback = function() vim.cmd [[ startinsert ]] end,
})

vim.g.gitblame_ignored_filetypes = {'netrw', 'gitcommit'}

vim.keymap.set('n', '[g', ':exe ":<c-u>call sy#jump#prev_hunk(v:count1)"<cr>', { noremap = true, silent = true })
vim.keymap.set('n', ']g', ':exe ":<c-u>call sy#jump#next_hunk(v:count1)"<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<space>d', '<cmd>SignifyHunkDiff<cr>', { noremap = true, silent = true })

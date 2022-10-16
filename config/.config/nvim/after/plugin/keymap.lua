-- Swap paned buffers with ctrl+<hjkl>
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')

-- Move selected lines with shift+<JK>
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

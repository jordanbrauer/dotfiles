-- Colemak
vim.keymap.set({'n', 'v'}, 'h', '<Up>')
vim.keymap.set({'n', 'v'}, 'k', '<Down>')
vim.keymap.set({'n', 'v'}, 'j', '<Left>')
vim.keymap.set({'n', 'v'}, 'l', '<Right>')

-- Swap paned buffers with ctrl+<hjkl>
vim.keymap.set('n', '<C-j>', '<C-W>h')
vim.keymap.set('n', '<C-h>', '<C-W>k')
vim.keymap.set('n', '<C-k>', '<C-W>j')
vim.keymap.set('n', '<C-l>', '<C-W>l')

-- Move selected lines with shift+<JK>
vim.keymap.set('v', 'K', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', 'H', ":m '<-2<CR>gv=gv", { noremap = true })

-- Use <Tab> and <S-Tab> to navigate through popup menus
-- QUESTION: are these needed anymore?
-- vim.keymap.set('i', '<Tab>', function() if vim.fn.pumvisible() then return '<C-n>' else return '<Tab>' end end, { noremap = true, expr = true })
-- vim.keymap.set('i', '<S-Tab>', function() if vim.fn.pumvisible() then return '<C-p>' else return '<S-Tab>' end end, { noremap = true, expr = true })

-- Harpoon
vim.keymap.set('n', '<leader>c', require('harpoon.ui').toggle_quick_menu, { silent = true, noremap = true })
vim.keymap.set('n', '<leader>a', require('harpoon.mark').add_file, { silent = true, noremap = true })

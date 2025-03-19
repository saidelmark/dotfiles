local set_keymap = require('saidelman.functions').set_keymap

-- Reset leader and localleader behaviour
vim.keymap.set({ 'n', 'v' }, ' ', '<nop>', { buffer = false })
vim.keymap.set({ 'n', 'v' }, '\\', '<nop>', { buffer = false })
set_keymap(' ', '<nop>', 'Reset leader', { buffer = false }, { 'n', 'v' })
set_keymap('\\', '<nop>', 'Reset leader', { buffer = false }, { 'n', 'v' })
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

set_keymap(';', ':', 'Switch ; and :', { silent = false, buffer = false }, { 'n', 'v' })
set_keymap(':', ';', 'Switch ; and :', { silent = false, buffer = false }, { 'n', 'v' })

set_keymap('<F2>', ':w<CR>', 'Save file Far Manager style', { buffer = false })
set_keymap('<F2>', '<ESC><C-G>:w<CR>a', 'Save file Far Manager style', { buffer = false }, 'i')
set_keymap('<F2>', ':w<CR>', 'Save file Far Manager style', { buffer = false }, 'v')

set_keymap('<leader>ev', ':vsplit $MYVIMRC<CR>', 'Edit init.vim', { buffer = false })
set_keymap('<leader>es', ':split $MYVIMRC<CR>', 'Edit init.vim', { buffer = false })

set_keymap(' G', ':vert G | vert resize 70<cr>', 'Git status', { buffer = false })

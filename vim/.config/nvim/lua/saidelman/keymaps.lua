local map = require('saidelman.functions').map
local dot = require('saidelman.functions').dot_repeat

-- Reset leader and localleader behaviour
vim.keymap.set({ 'n', 'v' }, ' ', '<nop>', { buffer = false })
vim.keymap.set({ 'n', 'v' }, '\\', '<nop>', { buffer = false })
map(' ', '<nop>', 'Reset leader', { buffer = false }, { 'n', 'v' })
map('\\', '<nop>', 'Reset leader', { buffer = false }, { 'n', 'v' })
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

map(';', ':', 'Switch ; and :', { silent = false, buffer = false }, { 'n', 'v' })
map(':', ';', 'Switch ; and :', { silent = false, buffer = false }, { 'n', 'v' })

map('<F2>', ':update<CR>', 'Save file Far Manager style', { buffer = false })
map('<F2>', '<ESC><C-G>:update<CR>a', 'Save file Far Manager style', { buffer = false }, 'i')
map('<F2>', '<ESC>:update<CR>gv', 'Save file Far Manager style', { buffer = false }, 'v')

map('<leader>ev', ':vsplit $MYVIMRC<CR>', 'Edit init.vim', { buffer = false })
map('<leader>es', ':split $MYVIMRC<CR>', 'Edit init.vim', { buffer = false })

map('<leader>G', ':vert G | vert resize 70<cr>', 'Git status', { buffer = false })

-- Things I miss from tpope's unimpaired

map('yow', ':set wrap!<cr>', 'Toggle wrap', { buffer = false })
map('yor', ':set relativenumber!<cr>', 'Toggle relative line numbers', { buffer = false })
map('yon', ':set relativenumber! number!<cr>', 'Toggle line numbering', { buffer = false })
map('yos', ':set spell!<cr>', 'Toggle spell checking', { buffer = false })

local map = require('saidelman.functions').map
local dot = require('saidelman.functions').dot_repeat

-- Reset leader and localleader behaviour
-- vim.keymap.set({ 'n', 'v' }, ' ', '<nop>', { buffer = false })
-- vim.keymap.set({ 'n', 'v' }, '\\', '<nop>', { buffer = false })
map(' ', '<nop>', 'Reset leader', {  }, { 'n', 'v' })
map('\\', '<nop>', 'Reset localleader', {  }, { 'n', 'v' })
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

map(';', ':', 'Switch ; and :', { silent = false }, { 'n', 'v' })
map(':', ';', 'Switch ; and :', { silent = false }, { 'n', 'v' })

map('<F2>', ':update<CR>', 'Save file Far Manager style')
map('<F2>', '<ESC><C-G>:update<CR>a', 'Save file Far Manager style', {}, 'i')
map('<F2>', '<ESC>:update<CR>gv', 'Save file Far Manager style', {}, 'v')

map('<leader>ev', ':vsplit $MYVIMRC<CR>', 'Edit init.vim')
map('<leader>es', ':split $MYVIMRC<CR>', 'Edit init.vim')

map('<leader>G', ':vert G | vert resize 70<cr>', 'Git status')

-- Things I miss from tpope's unimpaired

map('yow', ':set wrap!<cr>', 'Toggle wrap')
map('yor', ':set relativenumber!<cr>', 'Toggle relative line numbers')
map('yon', ':set relativenumber! number!<cr>', 'Toggle line numbering')
map('yos', ':set spell!<cr>', 'Toggle spell checking')

-- More convenient scrolling
map("<C-d>", "<C-d>zz", "Scroll down and center")
map("<C-u>", "<C-u>zz", "Scroll up and center")
map("<C-f>", "<C-f>zz", "Scroll down and center")
map("<C-b>", "<C-b>zz", "Scroll up and center")

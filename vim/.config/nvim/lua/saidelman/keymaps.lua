local map = require('saidelman.functions').map

-- Reset leader and localleader behaviour
vim.keymap.set({ 'n', 'v' }, ' ', '<nop>', { buffer = false })
vim.keymap.set({ 'n', 'v' }, '\\', '<nop>', { buffer = false })
map(' ', '<nop>', 'Reset leader', { buffer = false }, { 'n', 'v' })
map('\\', '<nop>', 'Reset leader', { buffer = false }, { 'n', 'v' })
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

map(';', ':', 'Switch ; and :', { silent = false, buffer = false }, { 'n', 'v' })
map(':', ';', 'Switch ; and :', { silent = false, buffer = false }, { 'n', 'v' })

map('<F2>', ':w<CR>', 'Save file Far Manager style', { buffer = false })
map('<F2>', '<ESC><C-G>:w<CR>a', 'Save file Far Manager style', { buffer = false }, 'i')
map('<F2>', ':w<CR>', 'Save file Far Manager style', { buffer = false }, 'v')

map('<leader>ev', ':vsplit $MYVIMRC<CR>', 'Edit init.vim', { buffer = false })
map('<leader>es', ':split $MYVIMRC<CR>', 'Edit init.vim', { buffer = false })

map('<leader>G', ':vert G | vert resize 70<cr>', 'Git status', { buffer = false })

-- Things I miss from tpope's unimpaired

--- @param before boolean
local function add_new_line(before)
  local current_line = vim.api.nvim_win_get_cursor(0)
  if before then
    vim.api.nvim_command('normal! O')
  else
    vim.api.nvim_command('normal! o')
  end
  vim.api.nvim_win_set_cursor(0, { 1 + current_line[1], current_line[2] })
end

map('[ ',
  function() add_new_line(true) end,
  'Add new line before current',
  { buffer = false }
)

map('] ',
  function() add_new_line(false) end,
  'Add new line after current',
  { buffer = false }
)

map('yow', ':set wrap!<cr>', 'Toggle wrap', { buffer = false })
map('yor', ':set relativenumber!<cr>', 'Toggle relative line numbers', { buffer = false })
map('yon', ':set relativenumber! number!<cr>', 'Toggle line numbering', { buffer = false })
map('yos', ':set spell!<cr>', 'Toggle spell checking', { buffer = false })

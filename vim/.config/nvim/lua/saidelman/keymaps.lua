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

set_keymap('<leader>G', ':vert G | vert resize 70<cr>', 'Git status', { buffer = false })


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

set_keymap(
  '[ ',
  function() add_new_line(true) end,
  'Add new line before current',
  { buffer = false }
)

set_keymap(
  '] ',
  function() add_new_line(false) end,
  'Add new line after current',
  { buffer = false }
)

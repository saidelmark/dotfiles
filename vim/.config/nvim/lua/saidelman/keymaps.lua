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

map('<F2>', ':w<CR>', 'Save file Far Manager style', { buffer = false })
map('<F2>', '<ESC><C-G>:w<CR>a', 'Save file Far Manager style', { buffer = false }, 'i')
map('<F2>', ':w<CR>', 'Save file Far Manager style', { buffer = false }, 'v')

map('<leader>ev', ':vsplit $MYVIMRC<CR>', 'Edit init.vim', { buffer = false })
map('<leader>es', ':split $MYVIMRC<CR>', 'Edit init.vim', { buffer = false })

map('<leader>G', ':vert G | vert resize 70<cr>', 'Git status', { buffer = false })

-- Things I miss from tpope's unimpaired

--- @param before boolean
local function add_new_line(before)
  local current_pos = vim.api.nvim_win_get_cursor(0)
  if before then
    vim.api.nvim_buf_set_lines(0, current_pos[1] - 1, current_pos[1] - 1, false, { "" })
    current_pos[1] = current_pos[1] + 1
  else
    vim.api.nvim_buf_set_lines(0, current_pos[1], current_pos[1], false, { "" })
  end
  vim.api.nvim_win_set_cursor(0, current_pos)
end

map('[ ',
  dot(function() add_new_line(true) end),
  'add new line before current',
  { buffer = false, expr = true, remap = true }
)

map('] ',
  dot(function() add_new_line(false) end),
  'add new line after current',
  { buffer = false, expr = true, remap = true }
)

map('yow', ':set wrap!<cr>', 'Toggle wrap', { buffer = false })
map('yor', ':set relativenumber!<cr>', 'Toggle relative line numbers', { buffer = false })
map('yon', ':set relativenumber! number!<cr>', 'Toggle line numbering', { buffer = false })
map('yos', ':set spell!<cr>', 'Toggle spell checking', { buffer = false })

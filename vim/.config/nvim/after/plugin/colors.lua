vim.o.background = 'dark'

local monokai = require('monokai')
local palette = monokai.classic
local bg = 'none'
-- local bg = '#181810'
monokai.setup {
  palette = {
    diff_text = '#133337',
  },
  custom_hlgroups = {
    CursorLine = {
      style = 'underline'
    },
    ErrorMsg = {
      fg = palette.red,
      style = 'italic'
    },
    GitSignsAdd = {
      fg = palette.green,
      bg = bg
    },
    GitSignsDelete = {
      fg = palette.pink,
      bg = bg
    },
    GitSignsChange = {
      fg = palette.orange,
      bg = bg
    },
    LineNr = {
      bg = bg
    },
    Normal = {
      bg = bg
    },
    SignColumn = {
      bg = bg
    },
    TSInclude = {
      fg = palette.aqua,
    },
    Visual = {
      bg = palette.black,
    },
  }
}
vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'SignColumn', { link = 'LineNr' })

require('colorizer').setup({ user_default_options = { mode = 'virtualtext', } })

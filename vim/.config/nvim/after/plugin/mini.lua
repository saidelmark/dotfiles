require('mini.ai').setup()
require('mini.bracketed').setup()
require('mini.indentscope').setup()
require('mini.pairs').setup()
require('mini.surround').setup({
  mappings = {
    add = 'ys',
    delete = 'ds',
    replace = 'cs',
  }
})
require('mini.splitjoin').setup({ mappings = { toggle = 'ss' } })
require('mini.move').setup()

require('mini.tabline').setup()
require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()
require('mini.notify').setup({
  lsp_progress = { enable = false },
  window = { config = { border = 'rounded' } },
})

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'n', keys = '\\' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
  window = {
    config = {
      border = 'rounded',
    },
    delay = 500,
  },
})

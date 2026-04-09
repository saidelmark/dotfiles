vim.keymap.set('n', '-', require('oil').open, { desc = 'Open parent directory' })
require('oil').setup({
  view_options = {
    case_insensitive = true,
    show_hidden = true,
  },
})

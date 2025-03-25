require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    theme = require('ofirkai.statuslines.lualine').theme,
  },
  -- TODO: Find out why this doesn't work
  extentions = { 'fugitive', 'fzf', 'oil' },
  sections = {
    lualine_c = { {
      'filename',
      path = 1,
      symbols = {
        modified = '●',
        readonly = '',
      }
    } },
    lualine_x = { { 'filetype', icon_only = true, colored = true, } },
    lualine_z = { 'location', 'searchcount' },
  },
  inactive_sections = {
    lualine_b = { 'diff', 'diagnostics' },
  },

  winbar = {},
})

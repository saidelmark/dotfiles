local ofirkai_theme = require('ofirkai.statuslines.lualine').theme
-- By default, filenames in inactive windows are almost invisible,
-- so I want to add more contrast (trying to stay withing the same color scheme)
ofirkai_theme.inactive.c.fg = ofirkai_theme.normal.a.bg
require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    theme = ofirkai_theme,
  },
  -- TODO: Find out why this doesn't work
  extentions = { 'fugitive', 'fzf', 'man', 'oil', 'quickfix', },
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

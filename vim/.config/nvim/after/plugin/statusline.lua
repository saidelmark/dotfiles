require('lualine').setup({
  options = {
    section_separators = '', component_separators = ''
  },
  sections = {
    lualine_x = { 'filetype' },
    lualine_z = { 'location', 'searchcount' },
  },
  inactive_sections = {
    lualine_b = { 'diff', 'diagnostics' },
  },
})

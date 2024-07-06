require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    theme = require('ofirkai.statuslines.lualine').theme,
  },
  -- TODO: Find out why this doesn't work
  extentions = { 'oil', 'fugitive' },
  sections = {
    lualine_x = { 'filetype' },
    lualine_z = { 'location', 'searchcount' },
  },
  inactive_sections = {
    lualine_b = { 'diff', 'diagnostics' },
  },

  tabline = {
    lualine_a = {
      {
        'windows',
        windows_color = {
          active = 'lualine_a_normal',
          inactive = 'lualine_b_inactive',
        },
        disabled_buftypes = { 'quickfix', 'prompt', 'lua' },
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        'tabs',
        max_length = vim.o.columns / 3,
        mode = 2,
        tabs_color = {
          active = 'lualine_a_normal',
          inactive = 'lualine_b_inactive',
        },
        fmt = function(name, context)
          local buflist = vim.fn.tabpagebuflist(context.tabnr)
          local winnr = vim.fn.tabpagewinnr(context.tabnr)
          local bufnr = buflist[winnr]
          local mod = vim.fn.getbufvar(bufnr, '&mod')
          return name .. (mod == 1 and ' +' or '')
        end
      }
    },
  },
  winbar = {},
})

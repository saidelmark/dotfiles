vim.o.background = 'dark'

local ofirkai = require('ofirkai')
local of_scheme = ofirkai.scheme
ofirkai.setup({
  custom_hlgroups = {
    LineNr = { fg = of_scheme.comment_fg },
    CursorLineNr = { fg = of_scheme.line_fg },
  }
})

require('colorizer').setup({ user_default_options = { mode = 'virtualtext', } })

-- Not sure about all the reasons, but looks like this:
-- git messenger uses default NormalFLoat hl group for popup windows,
-- and the border there is almost invisible.
-- Other plugins with popups either use some other mechanism or override the highlights.
-- Looking through `:h highlight-groups` I found that Conceal looks great in my current theme:
-- not too bright and distracting, but still visible
vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Conceal' })
vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'gitmessengerHeader', { link = 'Statement' })
vim.api.nvim_set_hl(0, 'gitmessengerHash', { link = 'Special' })
vim.api.nvim_set_hl(0, 'gitmessengerHistory', { link = 'Title' })

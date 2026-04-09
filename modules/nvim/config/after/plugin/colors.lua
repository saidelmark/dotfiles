vim.o.background = 'dark'

local ofirkai = require('ofirkai')
-- local scheme = ofirkai.scheme
ofirkai.setup({
  theme = 'dark_blue',
  custom_hlgroups = {
    -- LineNr = { fg = scheme.comment_fg },
    -- CursorLineNr = { fg = scheme.orange },
    -- Not sure about all the reasons, but looks like this:
    -- git messenger uses default NormalFLoat hl group for popup windows,
    -- and the border there is almost invisible.
    -- Other plugins with popups either use some other mechanism or override the highlights.
    -- Looking through `:h highlight-groups` I found that Conceal looks great in my current theme:
    -- not too bright and distracting, but still visible
    FloatBorder = { link = 'Conceal' },
    NormalFloat = { link = 'Normal' },
    gitmessengerHeader = { link = 'Statement' },
    gitmessengerHash = { link = 'Special' },
    gitmessengerHistory = { link = 'Title' },
    CopilotSuggestion = { link = 'Comment', italic = true, },
    SagaLightBulb = { link = 'CursorLineNr' },
  }
})

require('colorizer').setup({
  options = {
    parsers = {
      names = { enable = false },
      hex = { enable = true },
      rgb = { enable = true },
    },
    display = {
      mode = "virtualtext",
      virtualtext = { position = "after" },
    },
  },
})

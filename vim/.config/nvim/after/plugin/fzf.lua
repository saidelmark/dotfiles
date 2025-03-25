local fzf = require('fzf-lua')
fzf.setup()
fzf.setup_fzfvim_cmds()
fzf.register_ui_select()

local map = require('saidelman.functions').map
map('<C-M-P>',
  function()
    fzf.files({ fzf_opts = { ['--query'] = vim.fn.expand('%:p:.:h') } })
  end,
  "Fzf: Files in the same directory",
  { buffer = false }
)
map('<C-P>', fzf.files, "Fzf: Files", { buffer = false })

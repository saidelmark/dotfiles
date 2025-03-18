local fzf = require('fzf-lua')
fzf.setup()
fzf.setup_fzfvim_cmds()
fzf.register_ui_select()

local set_keymap = require('saidelman.functions').set_keymap
set_keymap(
  '<C-M-P>',
  function()
    fzf.files({ fzf_opts = { ['--query'] = vim.fn.expand('%:p:.:h') } })
  end,
  "Fzf: Available commands",
  { buffer = false }
)
set_keymap('<C-P>', fzf.files, "Fzf: Files", { buffer = false })

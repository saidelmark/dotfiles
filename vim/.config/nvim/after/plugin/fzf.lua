local fzf = require('fzf-lua')
fzf.setup({
  keymaps = {
    show_details    = false,
    ignore_patterns = { "^<SNR>" },
    actions         = {
      ["alt-d"] = function(_, opts)
        fzf.actions.toggle_opt(opts, 'show_details')
      end
    }
  },
  grep = {
    actions = {
      ["ctrl-r"] = { fzf.actions.toggle_ignore }
    }
  }
})
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

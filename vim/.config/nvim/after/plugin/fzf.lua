require('fzf-lua').setup({})
require('fzf-lua').setup_fzfvim_cmds()

local set_keymap = require('saidelman.functions').set_keymap
set_keymap('<C-M-P>', ':FzfLua commands<CR>', "Fzf: Available commands", {buffer = false})
set_keymap('<C-P>', ':FzfLua files<CR>', "Fzf: Files", {buffer = false})

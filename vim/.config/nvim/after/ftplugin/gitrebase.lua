local set_keymap = require('saidelman/functions').set_keymap

set_keymap('<localleader>p', '0ciwpick<esc>0', 'Rebase: Pick this commit')
set_keymap('<localleader>d', '0ciwdrop<esc>0', 'Rebase: Drop this commit')
set_keymap('<localleader>e', '0ciwedit<esc>0', 'Rebase: Edit this commit')
set_keymap('<localleader>s', '0ciwsquash<esc>0', 'Rebase: Squash this commit')
set_keymap('<localleader>f', '0ciwfixup<esc>0', 'Rebase: Fixup this commit')
set_keymap('<localleader>x', 'oexec <c-g>u', 'Rebase: Exec before this commit')
set_keymap('<localleader>X', 'Oexec <c-g>u', 'Rebase: Exec after this commit')
vim.opt_local.foldlevel = 99

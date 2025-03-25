local map = require('saidelman/functions').map

map('<localleader>p', '0ciwpick<esc>0', 'Rebase: Pick this commit')
map('<localleader>d', '0ciwdrop<esc>0', 'Rebase: Drop this commit')
map('<localleader>e', '0ciwedit<esc>0', 'Rebase: Edit this commit')
map('<localleader>s', '0ciwsquash<esc>0', 'Rebase: Squash this commit')
map('<localleader>f', '0ciwfixup<esc>0', 'Rebase: Fixup this commit')
map('<localleader>x', 'oexec <c-g>u', 'Rebase: Exec before this commit')
map('<localleader>X', 'Oexec <c-g>u', 'Rebase: Exec after this commit')
vim.opt_local.foldlevel = 99

local function set_buf_keymap(map, cmd)
  vim.keymap.set('n', map, cmd, { buffer = true, silent = true, noremap = true })
end

set_buf_keymap('<localleader>p', '0ciwpick<esc>0')
set_buf_keymap('<localleader>r', '0ciwreword<esc>0')
set_buf_keymap('<localleader>d', '0ciwdrop<esc>0')
set_buf_keymap('<localleader>e', '0ciwedit<esc>0')
set_buf_keymap('<localleader>s', '0ciwsquash<esc>0')
set_buf_keymap('<localleader>f', '0ciwfixup<esc>0')
set_buf_keymap('<localleader>x', 'oexec <c-g>u')
set_buf_keymap('<localleader>X', 'Oexec <c-g>u')

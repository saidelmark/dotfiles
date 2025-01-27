local ufo = require('ufo')
local set_keymap = require('saidelman.functions').set_keymap

vim.o.foldcolumn = '0'
vim.o.foldlevel = 15
vim.o.foldlevelstart = 15
vim.o.foldenable = true
set_keymap('zR', ufo.openAllFolds, "Folds: open all")
set_keymap('zM', ufo.closeAllFolds, "Folds: close all")
-- This doesn't work, ufo plugin currently has no support for vim's 'zm' and 'zr' behaviour
-- vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
-- 'zm' is partially supported, though '2zm', '7zm'
set_keymap('zm', ufo.closeFoldsWith, "Folds: close N levels")

ufo.setup({
---@diagnostic disable-next-line: unused-local
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})

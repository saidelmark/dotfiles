local ufo = require('ufo')
local map = require('saidelman.functions').map

vim.o.foldcolumn = '0'
vim.o.foldlevel = 15
vim.o.foldlevelstart = 15
vim.o.foldenable = true
map('zR', ufo.openAllFolds, "Folds: open all")
map('zM', ufo.closeAllFolds, "Folds: close all")
-- This doesn't work, ufo plugin currently has no support for vim's 'zm' and 'zr' behaviour
-- vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
-- 'zm' is partially supported, though '2zm', '7zm'
map('zm', ufo.closeFoldsWith, "Folds: close N levels")

ufo.setup({
---@diagnostic disable-next-line: unused-local
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})

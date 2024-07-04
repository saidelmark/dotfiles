local ufo = require('ufo')

vim.o.foldcolumn = '0'
vim.o.foldlevel = 9
vim.o.foldlevelstart = 9
vim.o.foldenable = true
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
-- This doesn't work, ufo plugin currently has no support for vim's 'zm' and 'zr' behaviour
-- vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
-- 'zm' is partially supported, though '2zm', '7zm'
vim.keymap.set('n', 'zm', ufo.closeFoldsWith, {})

ufo.setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})

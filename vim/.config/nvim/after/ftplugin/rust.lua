require('saidelman.lsp').lsp_common_keymaps()
require("neotest").setup({
  adapters = {
    require('rustaceanvim.neotest')
  }
})

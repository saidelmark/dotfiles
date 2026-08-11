vim.g.rustaceanvim = {
  server = {
    on_attach = require('saidelman.lsp').lsp_common_keymaps,
  }
}
vim.g.diffs = {
  -- NOTE: This dict is the configuration for diffs.nvim, it *has* to be loaded before the plugin itself
  integrations    = {
    fugitive = true,
    gitsigns = true,
  },
  extra_filetypes = { 'diff', 'gitmessengerpopup' },
  highlights      = {
    vim = {
      enable = true,
    },
  },
}

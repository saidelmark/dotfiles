require("lsp_lines").setup()
vim.diagnostic.config({ virtual_lines = false })
vim.keymap.set(
  "n",
  "<Leader>ll",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)

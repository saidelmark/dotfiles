require('hlargs').setup()
-- vim.treesitter.start()
-- Disable treesitter in favor of lsp semantic tokens if language server supports it
vim.api.nvim_create_augroup("LspAttach_hlargs", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_hlargs",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local caps = client.server_capabilities
    if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
      require("hlargs").disable_buf(args.buf)
      vim.treesitter.stop(args.buf)
    end
  end,
})

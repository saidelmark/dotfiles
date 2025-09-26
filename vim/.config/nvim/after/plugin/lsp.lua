require('lspsaga').setup {
  lightbulb = {
    enable = true,
    sign = true,
    virtual_text = false,
    update_in_insert = true,
  },
}
local on_attach = require('saidelman.lsp').lsp_common_keymaps
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

if vim.fn.executable('lua-language-server') == 1 then
  vim.lsp.enable("lua_ls")
  vim.lsp.config(
    "lua_ls",
    {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }
  )
end

if vim.fn.executable('haskell-language-server-wrapper') == 1 then
  vim.lsp.enable("hls")
  vim.lsp.config(
    "hls",
    {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  )
end

if vim.fn.executable('terraform-ls') == 1 then
  vim.lsp.enable("terraformls")
  vim.lsp.config(
    "terraformls",
    {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  )
end

if vim.fn.executable('nixd') == 1 then
  vim.lsp.enable("nixd")
  vim.lsp.config(
    "nixd",
    {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  )
end

if vim.fn.executable('bash-language-server') == 1 then
  vim.lsp.enable("bashls")
  vim.lsp.config(
    "bashls",
    {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  )
end

if vim.fn.executable('vim-language-server') == 1 then
  vim.lsp.enable("vimls")
  vim.lsp.config(
    "vimls",
    {
      on_attach = on_attach,
      init_options = {
        isNeovim = true,
      },
      capabilities = capabilities,
    }
  )
end

if vim.fn.executable('yaml-language-server') == 1 then
  vim.lsp.enable("yamlls")
  vim.lsp.config(
    "yamlls",
    {
      on_attach = on_attach,
      settings = {
        yaml = {
          schemas = {
            -- looks like kubernetes schemas are not working
            kubernetes = { '/*.yaml' },
          },
        },
      },
      capabilities = capabilities,
    }
  )
end

if vim.fn.executable('pylsp') == 1 then
  vim.lsp.enable("pylsp")
  vim.lsp.config(
    "pylsp",
    {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  )
end

if vim.fn.executable('rust-analyzer') == 1 then
  require('crates').setup({
    lsp = {
      enabled = true,
      on_attach = on_attach,
      actions = true,
      completion = true,
      hover = true,
    }
  })
end

vim.diagnostic.config({
  signs = true,
  virtual_text = false,
  underline = false,
  virtual_lines = false,
  update_in_insert = true,
})

require('fidget').setup({})

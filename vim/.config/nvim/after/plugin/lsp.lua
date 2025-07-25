local nvim_lsp = require('lspconfig')

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
  nvim_lsp.lua_ls.setup {
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
end

if vim.fn.executable('haskell-language-server-wrapper') == 1 then
  nvim_lsp.hls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if vim.fn.executable('terraform-ls') == 1 then
  nvim_lsp.terraformls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if vim.fn.executable('nixd') == 1 then
  nvim_lsp.nixd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if vim.fn.executable('bash-language-server') == 1 then
  nvim_lsp.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if vim.fn.executable('vim-language-server') == 1 then
  nvim_lsp.vimls.setup {
    on_attach = on_attach,
    init_options = {
      isNeovim = true,
    },
    capabilities = capabilities,
  }
end

if vim.fn.executable('yaml-language-server') == 1 then
  nvim_lsp.yamlls.setup {
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
end

if vim.fn.executable('pylsp') == 1 then
  nvim_lsp.pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
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

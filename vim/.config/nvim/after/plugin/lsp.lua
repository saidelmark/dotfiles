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
  require('crates').setup {}
end

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      underline = false,
      update_in_insert = true,
    })

require('fidget').setup({})
-- The line below is a switch to turn the lsp_lines plugin on or off
-- Maybe it would be better to make it into a keymap
-- vim.diagnostic.config({ virtual_lines = true })
-- Another option is to only enable virtual text diagnostics for current line.
-- It looks very strange in rust, when a diagnostic message is spread across the whole file,
-- but may be useful in other languages:
-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })


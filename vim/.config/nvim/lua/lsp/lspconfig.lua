local nvim_lsp = require('lspconfig')

require 'lspsaga'.init_lsp_saga{
  code_action_prompt = {
    enable = true,
    sign = true,
    virtual_text = false,
  },
  border_style = "round",
}
---@diagnostic disable-next-line: unused-local
local on_attach = function (client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap=true, silent=true }

  -- Unimplemented by a lot of servers
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- TODO: add mapping for range_formatting()
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)

  buf_set_keymap('n', '<Leader>gh', ":Lspsaga lsp_finder<CR>", opts)
  buf_set_keymap('n', '<Leader><c-]>', ":Lspsaga preview_definition<CR>", opts)
  buf_set_keymap('n', '<Leader>ld', ":Lspsaga show_line_diagnostics<CR>", opts)
  buf_set_keymap('n', '[d', ":Lspsaga diagnostic_jump_prev<CR>", opts)
  buf_set_keymap('n', ']d', ":Lspsaga diagnostic_jump_next<CR>", opts)
  buf_set_keymap('n', '<C-k>', ":Lspsaga signature_help<CR>", opts)
  buf_set_keymap('n', 'K', ":Lspsaga hover_doc<CR>", opts)
  -- TODO: add code action for ranges (visual mode)
  buf_set_keymap('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
  buf_set_keymap('n', '<c-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
  buf_set_keymap('n', '<c-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  vim.wo.signcolumn = 'yes'
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

if vim.fn.executable("lua-language-server") == 1 then
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")
  nvim_lsp.sumneko_lua.setup{
    on_attach = on_attach,
    cmd = { "/usr/bin/lua-language-server" },
    Lua = {
      diagnostics = {
        enable = true,
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      filetypes = {'lua'},
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
    capabilities = capabilities,
  }
end

if vim.fn.executable("haskell-language-server-wrapper") == 1 then
  nvim_lsp.hls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if vim.fn.executable("terraform-ls") == 1 then
  nvim_lsp.terraformls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if vim.fn.executable("rnix-lsp") == 1 then
  nvim_lsp.rnix.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if vim.fn.executable("bash-language-server") == 1 then
  nvim_lsp.bashls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if vim.fn.executable("vim-language-server") == 1 then
  nvim_lsp.vimls.setup{
    on_attach = on_attach,
    init_options = {
      isNeovim = true,
    },
    capabilities = capabilities,
  }
end

if vim.fn.executable("yaml-language-server") == 1 then
  nvim_lsp.yamlls.setup{
    on_attach = on_attach,
    settings = {
      yaml = {
        schemas = {
          -- looks like kubernetes schemas are not working
          kubernetes ={  "/*.yaml" },
        },
      },
    },
    capabilities = capabilities,
  }
end

if vim.fn.executable("pylsp") == 1 then
  nvim_lsp.pylsp.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if vim.fn.executable("rust-analyzer") == 1 then
  local rt = require("rust-tools")
  local on_attach_rust = function (client, bufnr)
    on_attach(client, bufnr)
    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
  end
  local rust_opts = {
    tools = {
      autoSetHints = true,
      -- hover_with_actions = true,
      inlay_hints = {
        show_parameter_hints = true,
      },
    },
    server = {
      on_attach = on_attach_rust,
      capabilities = capabilities,
      ["rust-analyzer"] = {
        assist = {
          importGranularity = "module",
          importPrefix = "self",
        },
        cargo = {
          loadOutDirsFromCheck = true
        },
        procMacro = {
          enable = true
        },
      }
    },
  }
  rt.setup(rust_opts)
end

vim.lsp.handlers['textDocument/publishDiagnostics'] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = false,
    underline = false,
    update_in_insert = true,
})

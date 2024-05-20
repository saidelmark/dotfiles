local nvim_lsp = require('lspconfig')

require 'lspsaga'.setup {
  lightbulb = {
    enable = true,
    sign = false,
    virtual_text = false,
    update_in_insert = true,
  },
}
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  local function set_keymap(mapping, command, opts, mode)
    mode = mode or 'n'
    opts = opts or {}
    local default_opts = { noremap = true, silent = true }
    for k,v in pairs(default_opts) do opts[k] = opts[k] or v end
    if type(command) == "function" then
      opts.callback = command
      command = ""
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, mapping, command, opts)
  end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- TODO: replace '<cmd>lua ...<CR>' with callbacks
  -- Unimplemented by a lot of servers
  set_keymap('gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  set_keymap('<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  set_keymap('<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  set_keymap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  set_keymap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  set_keymap('<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  -- TODO: add mapping for range_formatting()
  set_keymap('<leader>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>')

  set_keymap('<Leader>gh', ":Lspsaga finder<CR>")
  set_keymap('<Leader>go', ":Lspsaga outline<CR>")
  set_keymap('<Leader><c-]>', ":Lspsaga preview_definition<CR>")
  set_keymap('<Leader>ld', ":Lspsaga show_line_diagnostics<CR>")
  set_keymap('[d', ":Lspsaga diagnostic_jump_prev<CR>")
  set_keymap(']d', ":Lspsaga diagnostic_jump_next<CR>")
  -- There is no "signature_help" option
  -- buf_set_keymap('<C-k>', ":Lspsaga signature_help<CR>")
  set_keymap('K', ":Lspsaga hover_doc<CR>")
  -- TODO: add code action for ranges (visual mode)
  set_keymap('<leader>ca', ':Lspsaga code_action<CR>')
  set_keymap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

  vim.wo.signcolumn = 'yes'
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

if vim.fn.executable("lua-language-server") == 1 then
  nvim_lsp.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
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
          kubernetes = { "/*.yaml" },
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
    virtual_text = false,
    signs = true,
    underline = false,
    update_in_insert = true,
})

require"fidget".setup{}


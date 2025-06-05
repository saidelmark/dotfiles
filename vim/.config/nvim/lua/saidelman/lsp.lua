local M = {}

local map = require('saidelman/functions').map

---@diagnostic disable-next-line: unused-local
function M.lsp_common_keymaps(client, bufnr)
  local fzf = require('fzf-lua')
  local fzf_opts = { winopts = { preview = { hidden = false } } }
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

  map('<c-]>',
    function()
      fzf.lsp_definitions(vim.tbl_extend('keep', fzf_opts, { fzf_opts = { ["--select-1"] = true } }))
    end,
    'LSP: To definition')
  map('<leader>gt', vim.lsp.buf.type_definition, 'LSP: To type definition of symbol under cursor')
  map('<Leader>gi', function() fzf.lsp_implementations(fzf_opts) end, 'LSP: Implementations')
  map('<Leader>gr', function() fzf.lsp_references(fzf_opts) end, 'LSP: References')
  map('<leader>dd', function() fzf.lsp_document_diagnostics(fzf_opts) end, 'LSP: Document diagnostic')
  map('<leader>wd', function() fzf.lsp_workspace_diagnostics(fzf_opts) end, 'LSP: Workspace diagnostic')
  -- TODO: add mapping for range_formatting()
  map('<leader>f', function() vim.lsp.buf.format({ async = true }) end, 'LSP: Format document')

  map('<Leader>gf', function() fzf.lsp_finder(fzf_opts) end, 'LSP: Just find everything')
  map('<Leader>go', ':Lspsaga outline<CR>', 'LSP: Toggle outline')
  map('<Leader><c-]>', ':Lspsaga peek_definition<CR>', 'LSP: Peek definition in a floating window')
  map('<Leader>ld', ':Lspsaga show_line_diagnostics<CR>', 'LSP: Line diagnostic')
  map('[d', ':Lspsaga diagnostic_jump_prev<CR>', 'LSP: To prev diagnostic')
  map(']d', ':Lspsaga diagnostic_jump_next<CR>', 'LSP: To next diagnostic')
  map('K', ':Lspsaga hover_doc<CR>', 'LSP: Documentation')
  -- TODO: add code action for ranges (visual mode)
  map(
    "<leader>a",
    function() fzf.lsp_code_actions(fzf_opts) end,
    'LSP: Code actions'
  )
  map('<leader>rn', vim.lsp.buf.rename, 'LSP: Rename object')
  map('<leader>hh',
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    'LSP: Toggle inlay hints'
  )
  map('<Leader>ll', function()
    vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
  end, 'LSP: Toggle inline diagnostics')

  vim.wo.signcolumn = 'yes'
end

return M

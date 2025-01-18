local M = {}

local set_keymap = require('saidelman/functions').set_keymap

---@diagnostic disable-next-line: unused-local
function M.lsp_common_keymaps(client, bufnr)
  local fzf = require('fzf-lua')
  local fzf_opts = { winopts = { preview = { hidden = false } } }
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

  set_keymap('<c-]>',
    function()
      fzf.lsp_definitions(vim.tbl_extend('keep', fzf_opts, { fzf_opts = { ["--select-1"] = true } }))
    end,
    'LSP: To definition')
  set_keymap('<leader>gt', vim.lsp.buf.type_definition, 'LSP: To type definition of symbol under cursor')
  set_keymap('<Leader>gi', function() fzf.lsp_implementations(fzf_opts) end, 'LSP: Implementations')
  set_keymap('<Leader>gr', function() fzf.lsp_references(fzf_opts) end, 'LSP: References')
  set_keymap('<leader>dd', function() fzf.lsp_document_diagnostics(fzf_opts) end, 'LSP: Document diagnostic')
  set_keymap('<leader>wd', function() fzf.lsp_workspace_diagnostics(fzf_opts) end, 'LSP: Workspace diagnostic')
  -- TODO: add mapping for range_formatting()
  set_keymap('<leader>f', function() vim.lsp.buf.format({ async = true }) end, 'LSP: Format document')

  set_keymap('<Leader>gf', function() fzf.lsp_finder(fzf_opts) end, 'LSP: Just find everything')
  set_keymap('<Leader>go', ':Lspsaga outline<CR>', 'LSP: Toggle outline')
  set_keymap('<Leader><c-]>', ':Lspsaga peek_definition<CR>', 'LSP: Peek definition in a floating window')
  set_keymap('<Leader>ld', ':Lspsaga show_line_diagnostics<CR>', 'LSP: Line diagnostic')
  set_keymap('[d', ':Lspsaga diagnostic_jump_prev<CR>', 'LSP: To prev diagnostic')
  set_keymap(']d', ':Lspsaga diagnostic_jump_next<CR>', 'LSP: To next diagnostic')
  set_keymap('K', ':Lspsaga hover_doc<CR>', 'LSP: Documentation')
  -- TODO: add code action for ranges (visual mode)
  set_keymap(
    "<leader>a",
    function() fzf.lsp_code_actions(fzf_opts) end,
    'LSP: Code actions'
  )
  set_keymap('<leader>rn', vim.lsp.buf.rename, 'LSP: Rename object')
  set_keymap('<leader>hh',
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    'LSP: Toggle inlay hints'
  )
  if require('lsp_lines') then
    set_keymap('<Leader>ll', require('lsp_lines').toggle, 'LSP: Toggle inline diagnostics')
  end

  vim.wo.signcolumn = 'yes'
end

return M

local M = {}

local map = require('saidelman/functions').mapbuf

---@diagnostic disable-next-line: unused-local
function M.lsp_common_keymaps(client, bufnr)
  local fzf = require('fzf-lua')
  local fzf_opts = { winopts = { preview = { hidden = false } } }
  local lsp = vim.lsp
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

  map('grl', function()
    lsp.codelens.enable(not lsp.codelens.is_enabled())
  end, 'Toggle code lens')

  map('<c-]>',
    function()
      fzf.lsp_definitions(vim.tbl_extend('keep', fzf_opts, { fzf_opts = { ["--select-1"] = true } }))
    end,
    'LSP: To definition')
  map('grt', lsp.buf.type_definition, 'Go to type definition of symbol under cursor')
  map('gri', function() fzf.lsp_implementations(fzf_opts) end, 'Implementations')
  map('grr', function() fzf.lsp_references(fzf_opts) end, 'References')
  map('<leader>dd', function() fzf.lsp_document_diagnostics(fzf_opts) end, 'LSP: Document diagnostic')
  map('<leader>wd', function() fzf.lsp_workspace_diagnostics(fzf_opts) end, 'LSP: Workspace diagnostic')
  map('<leader>f', function() lsp.buf.format({ async = true }) end, 'LSP: Format document')
  map('<leader>f', function()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    lsp.buf.format({
      async = true,
      range = {
        start = { line = start_pos[2] - 1, character = start_pos[3] - 1 },
        ["end"] = { line = end_pos[2] - 1, character = end_pos[3] - 1 },
      },
    })
  end, 'LSP: Format selection', {}, 'v')


  map('<Leader>gf', function() fzf.lsp_finder(fzf_opts) end, 'LSP: Just find everything')
  map('<Leader><c-]>', ':Lspsaga peek_definition<CR>', 'LSP: Peek definition in a floating window')
  map('[d', ':Lspsaga diagnostic_jump_prev<CR>', 'LSP: To prev diagnostic')
  map(']d', ':Lspsaga diagnostic_jump_next<CR>', 'LSP: To next diagnostic')
  map(
    'gra',
    function() fzf.lsp_code_actions(fzf_opts) end,
    'Code actions'
  )
  map('<leader>hh',
    function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled()) end,
    'LSP: Toggle inlay hints'
  )
  map('<Leader>ll', function()
    vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
  end, 'LSP: Toggle inline diagnostics')

  vim.wo.signcolumn = 'yes'
end

return M

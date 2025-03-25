require('gitsigns').setup {
  signcolumn = true,
  numhl = false,
  preview_config = { border = 'rounded' },
  on_attach = function()
    local gs = package.loaded.gitsigns
    local map = require('saidelman.functions').map

    -- Navigation
    map(']h', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']h', bang = true })
      else
        gs.next_hunk()
      end
    end, '')

    map('[h', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[h', bang = true })
      else
        gs.prev_hunk()
      end
    end, '')

    -- Actions
    map('<leader>hs', gs.stage_hunk, 'Git: stage hunk or selection', {}, { 'n', 'v' })
    map('<leader>hr', gs.reset_hunk, 'Git: reset hunk or selection', {}, { 'n', 'v' })
    map('<leader>hS', gs.stage_buffer, 'Git: stage whole buffer')
    map('<leader>hR', gs.reset_buffer, 'Git: reset whole buffer')
    map('<leader>hp', gs.preview_hunk, 'Git: preview hunk')
    map('<leader>hd', function()
      if vim.wo.diff then
        vim.cmd('diffoff!')
        if #vim.api.nvim_list_tabpages() > 1 then
          vim.cmd('tabclose')
        end
      else
        vim.cmd('tabnew %')
        gs.diffthis()
      end
    end, 'Git: diff current file')
    map('<leader>hD', function() if not vim.wo.diff then
        vim.cmd('tabnew %')
        gs.diffthis('~')
      end end, 'Git: diff current file against HEAD~')

    -- Toggles
    map('<leader>tb', gs.toggle_current_line_blame, 'Git: toggle current line blame')
    map('<leader>td', gs.toggle_deleted, 'Git: toggle inline deleted')
    map('<leader>tw', gs.toggle_word_diff, 'Git: toggle word diff')

    -- Text object
    map('ih', ':<C-U>Gitsigns select_hunk<CR>', 'Git: select hunk operator', {}, { 'o', 'x' })
  end
}

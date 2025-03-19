local M = {}

--- Wrapper around vim keymap set with my defaults
--- @param mapping string
--- @param command string | function
--- @param description string
--- @param opts? vim.keymap.set.Opts
--- @param mode? string | string[]
function M.set_keymap(mapping, command, description, opts, mode)
  mode = mode or 'n'
  opts = opts or {}
  local default_opts = { remap = false, silent = true, buffer = true, desc = description }
  local res_opts = vim.tbl_extend('keep', opts, default_opts)
  if type(command) == 'function' then
    res_opts.callback = command
    command = ''
  end
  vim.keymap.set(mode, mapping, command, res_opts)
end

return M

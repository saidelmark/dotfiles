local M = {}

--- Wrapper around vim keymap set with my defaults
--- @param mapping string
--- @param command string | function
--- @param description string
--- @param opts? vim.keymap.set.Opts
--- @param mode? string | string[]
function M.map(mapping, command, description, opts, mode)
  mode = mode or 'n'
  opts = opts or {}
  local default_opts = {
    remap = false,
    silent = true,
    buffer = true,
    desc = description
  }
  local res_opts = vim.tbl_extend('keep', opts, default_opts)
  if type(command) == 'function' then
    res_opts.callback = command
    command = ''
  end
  vim.keymap.set(mode, mapping, command, res_opts)
end

--- Returns a dot repeatable version of a function to be used in keymaps
--- that pressing `.` will repeat the action.
--- Example: `vim.keymap.set('n', 'ct', dot_repeat(function() print(os.clock()) end), { expr = true })`
--- Setting expr = true in the keymap is required for this function to make the keymap repeatable
--- based on gist: https://gist.github.com/kylechui/a5c1258cd2d86755f97b10fc921315c3
--- The function is from https://www.reddit.com/r/neovim/comments/187q9ns/comment/kbh4431/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
function M.dot_repeat(
    callback --[[Function]]
)
    return function()
        _G.dot_repeat_callback = callback
        vim.go.operatorfunc = 'v:lua.dot_repeat_callback'
        return 'g@l'
    end
end

return M

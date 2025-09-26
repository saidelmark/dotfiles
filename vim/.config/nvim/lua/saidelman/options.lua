vim.opt.updatetime = 100

vim.opt.hidden = true
-- Ignore case when sort files in netrw
vim.g.netrw_sort_options = "i"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.winborder = "rounded"

vim.opt.scrolloff = 5

-- Enable mouse in all modes
vim.opt.mouse = "a"
-- This option changes default `tab` behavior
-- tabs are replaces with spaces and are 2 symbols wide
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- visible tabs and trailing spaces
vim.opt.list = true

-- This option shows the command on the bottom of the screen
vim.opt.showcmd = true

-- Don't save backup files
vim.opt.backup = false
vim.opt.writebackup = false

-- Better display for messages
vim.opt.cmdheight = 1

-- Provides completion for all file-related tasks
vim.opt.path:append("**")

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.filetype.add({
  pattern = {
    ['.*sxhkd.*'] = 'sxhkdrc'
  }
})

-- Triger `autoread` when files changes on disk
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI'}, {
  pattern = '*',
  command = "if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
})

-- Notification after file change
-- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
vim.api.nvim_create_autocmd({'FileChangedShellPost'}, {
  pattern = '*',
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})

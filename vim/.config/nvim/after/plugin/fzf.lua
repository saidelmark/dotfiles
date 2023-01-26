require("fzf-lua").setup({
  -- The following are keymamp active when fzf window is active
  keymap = {
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<F1>"]  = "toggle-help",
      ["<F2>"]  = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"]  = "toggle-preview-wrap",
      ["<F4>"]  = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"]  = "toggle-preview-ccw",
      ["<F6>"]  = "toggle-preview-cw",
      ["<M-j>"] = "preview-page-down",
      ["<M-k>"] = "preview-page-up",
    },
    fzf = {
      -- fzf '--bind=' options
      ["ctrl-z"]     = "abort",
      ["ctrl-u"]     = "unix-line-discard",
      ["ctrl-f"]     = "half-page-down",
      ["ctrl-b"]     = "half-page-up",
      ["ctrl-a"]     = "beginning-of-line",
      ["ctrl-e"]     = "end-of-line",
      ["alt-a"]      = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"]         = "toggle-preview-wrap",
      ["f4"]         = "toggle-preview",
      -- scrolling the preview
      ["shift-down"] = "preview-page-down",
      ["shift-up"]   = "preview-page-up",
      ["alt-j"]      = "preview-down",
      ["alt-k"]      = "preview-up",
    },
  },
})

vim.keymap.set('n', '<C-M-P>', ':FzfLua commands<CR>', { silent = true })
vim.keymap.set('n', '<C-P>', ':FzfLua files<CR>', { silent = true })

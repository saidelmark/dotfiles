vim.g.git_messenger_max_popup_height = 20
vim.g.git_messenger_max_popup_width = 80
vim.g.git_messenger_popup_content_margins = false
vim.g.git_messenger_always_into_popup = true

require("codediff").setup({
  highlights = {
    -- These are higlight groups provided by diffs.nvim plugin
    line_insert = "DiffsAdd",
    line_delete = "DiffsDelete",
    char_insert = "DiffsTextAdd",
    char_delete = "DiffsTextDelete",
  },
})

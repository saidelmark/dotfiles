vim.api.nvim_set_hl(0, 'gitmessengerHeader', { link = 'Statement' } )
vim.api.nvim_set_hl(0, 'gitmessengerHash', { link = 'Special' } )
vim.api.nvim_set_hl(0, 'gitmessengerHistory', { link = 'Title' } )

vim.g.git_messenger_max_popup_height = 20
vim.g.git_messenger_max_popup_width = 80
vim.g.git_messenger_floating_win_opts = { border = 'rounded' }
vim.g.git_messenger_popup_content_margins = false
vim.g.git_messenger_always_into_popup = true

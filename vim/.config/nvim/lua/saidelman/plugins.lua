vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'ofirgall/ofirkai.nvim'
  -- general quality of life
  use 'tpope/vim-sensible'
  use 'tpope/vim-unimpaired'
  use 'm4xshen/autoclose.nvim'
  use 'stevearc/oil.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-abolish'
  use 'mbbill/undotree'
  use 'michaeljsmith/vim-indent-object'
  use 'jeetsukumaran/vim-indentwise'
  use 'tversteeg/registers.nvim'
  use {
    'kevinhwang91/nvim-ufo',
    requires = { 'kevinhwang91/promise-async' }
  }
  use {
    'ibhagwan/fzf-lua',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }
  use 'dhruvasagar/vim-table-mode'
  use 'chentoast/marks.nvim'
  use 'lyokha/vim-xkbswitch'

  use {
    'ellisonleao/glow.nvim',
    config = function() require 'glow'.setup() end
  }

  -- visual
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'NvChad/nvim-colorizer.lua'

  -- git stuff
  use {
    'tpope/vim-fugitive',
    requires = {
      'junegunn/gv.vim',
      'tpope/vim-rhubarb',
      'shumphrey/fugitive-gitlab.vim',
    },
  }
  use 'lewis6991/gitsigns.nvim'
  use 'rhysd/git-messenger.vim'


  -- use 'tmux-plugins/vim-tmux'

  -- completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
    }
  }

  -- lsp and treesitter related
  use {
    'nvimdev/lspsaga.nvim',
    requires = { 'neovim/nvim-lspconfig' },
  }
  use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
  use 'j-hui/fidget.nvim'
  use { 'saecki/crates.nvim', tag = 'stable' }
  use { 'mrcjkb/rustaceanvim', version = "^5" }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdateSync',
  }
  use {
    'm-demare/hlargs.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
  }
  -- Test framework with adapters for different languages
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    }
  }
  use 'github/copilot.vim'
  use {
    'CopilotC-Nvim/CopilotChat.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'github/copilot.vim' },
    config = function() require('CopilotChat').setup() end,
  }
end)

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

  -- syntax for all languages I use
  use 'kovetskiy/sxhkd-vim'
  use 'neovimhaskell/haskell-vim'
  use 'chr4/nginx.vim'
  use 'towolf/vim-helm'
  use 'hashivim/vim-terraform'
  use 'tmux-plugins/vim-tmux'
  use 'LnL7/vim-nix'
  use 'timmyjose-projects/lox.vim'
  use 'cespare/vim-toml'

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
  use 'Maan2003/lsp_lines.nvim'
  use 'j-hui/fidget.nvim'
  use 'simrat39/rust-tools.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdateSync',
  }
  use {
    'm-demare/hlargs.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
  }
end)

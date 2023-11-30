require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "diff",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "hcl",
    "html",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "nix",
    "perl",
    "python",
    "rust",
    "sxhkdrc",
    "toml",
    "vim",
    "yaml",
  },
  sync_install = true,
  auto_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true
  },
}

require('hlargs').setup()

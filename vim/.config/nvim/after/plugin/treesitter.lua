require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "c",
    "dockerfile",
    "go",
    "gomod",
    "hcl",
    "html",
    "json",
    "lua",
    "nix",
    "perl",
    "python",
    "rust",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
  },
}

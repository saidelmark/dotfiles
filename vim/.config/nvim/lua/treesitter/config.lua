require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "go",
    "gomod",
    "hcl",
    "lua",
    "nix",
    "python",
  },
  highlight = {
    enable = false,
  }
}

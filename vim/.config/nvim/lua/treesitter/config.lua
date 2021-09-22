require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "go",
    "gomod",
    "hcl",
    "html",
    "json",
    "lua",
    "nix",
    "python",
    "yaml",
  },
  highlight = {
    enable = false,
  },
}

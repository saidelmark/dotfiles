{ pkgs, lib, ... }:
let
  theme = pkgs.vimUtils.buildVimPlugin {
    name = "ofirkai-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "ofirgall";
      repo = "ofirkai.nvim";
      rev = "261581c"; # It's just the colorscheme, I don't care about the latest and greatest, can manually update once in a while
      sha256 = "1w38rzwydhigqqg2d0whjck66cvsmggq3jhfi4195m3x643jrhh7";
    };
  };
  treesitter-with-grammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (
    treesitter-plugins: with treesitter-plugins; [
      bash
      comment
      csv
      dockerfile
      git_config
      git_rebase
      gitattributes
      gitignore
      go
      gomod
      hcl
      html
      jq
      json
      json5
      kdl
      lua
      luadoc
      make
      markdown
      markdown_inline
      nix
      perl
      python
      rasi # Maybe not needed after switching to niri
      rust
      ssh_config
      sxhkdrc # Maybe not needed after switching to niri
      toml
      vim
      vimdoc
      yaml
      zsh
    ]
  );
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
        bash-language-server
        copilot-language-server
        fzf
        git
        github-copilot-cli
        gopls
        lua-language-server
        nixd
        nixfmt
        ripgrep
        rust-analyzer
        vim-language-server
    ];
    initLua =
      let
        earlyInit = lib.mkOrder 10 /* lua */ "require('saidelman.before')";
        normalInit = /* lua */ ''
          require('saidelman.keymaps')
          require('saidelman.options')
        '';
      in
      lib.mkMerge [
        earlyInit
        normalInit
      ];
    plugins = with pkgs.vimPlugins; [
      theme
      vim-sensible # defaults that make sense
      oil-nvim # file explorer that is just a buffer
      vim-repeat # allows plugins to support the . operator for repeating actions
      vim-abolish # better support for searching and replacing, especially with different cases. Not sure if I use it that much
      undotree # undotree is built-in to neovim now, but this plugin is nicer
      registers-nvim # shows contents of every occupied register
      nvim-ufo # better folding, especially with treesitter
      fzf-lua # fzf integration
      vim-table-mode # markdown tables
      marks-nvim # shows marks in a nice way
      vim-xkbswitch # automatically switch input method when entering/leaving insert mode
      glow-nvim # markdown preview, maybe not necessary
      mini-nvim # collection of small plugins, I use several of them
      lualine-nvim # statusline
      nvim-colorizer-lua # shows colors in their actual color
      vim-fugitive # git integration
      gv-vim # git commit history, especially for the current file
      git-messenger-vim # shows git commit info for the current line
      gitsigns-nvim # shows git changes in the sign column
      diffs-nvim # changes higlights of git diffs, uses treesitter
      codediff-nvim # pretty powerful git diff viewer
      nvim-cmp # autocompletion framework
      cmp-nvim-lsp # LSP source for nvim-cmp
      cmp-buffer # buffer source for nvim-cmp
      cmp-path # path source for nvim-cmp
      # cmp-vsnip 
      # vim-vsnip
      cmp-nvim-lsp-signature-help # shows function signature help as you type
      cmp-cmdline # command line source for nvim-cmp
      lspkind-nvim # pretiier autocompletion menu
      lspsaga-nvim # opinionated UI for LSP features. One of the few I still use is "next/prev diagnostic", which shows the diagnostic after the jump. And a lightbulb. Has terrible help docs (it's essentially just a link to a website with some docs)
      fidget-nvim # shows LSP progress in a non-intrusive way
      crates-nvim # shows crate versions and updates for rust projects
      rustaceanvim # collection of rust tools
      treesitter-with-grammars
      hlargs-nvim # higlights arguments of a function throughout the function body
      neotest # UI and actions for testing
      copilot-vim # copilot code suggestions
      CopilotChat-nvim # copilot chat interface
      nvim-lspconfig # presets for LSP servers configs
    ];
  };
  xdg.configFile.nvim = {
    enable = true;
    recursive = true;
    source = ./config;
  };
}

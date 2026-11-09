{ config, pkgs, ... }:

{
  imports = [
    ./modules/nvim
    ./modules/tmux
    ./modules/zsh
  ];
  home = {
    username = "mark";
    homeDirectory = "/home/mark";

    stateVersion = "26.05";

    packages = with pkgs; [
      bat
      bottom
      cargo
      delta
      difftastic
      eza
      fd
      htop
      gh
      glow
      jq
      nh
      nix
      nix-tree
      nodejs # Only to enable copilot globally, not on every project
      mc
      pandoc
      ripgrep
      shellcheck
      skim
      tmux
      yq-go
      zoxide
    ];
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs = {
    home-manager.enable = true;
  };
}

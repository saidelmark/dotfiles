{ config, pkgs, ... }:

{
  imports = [
    ./modules/nvim
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
      nix
      nix-tree
      nodejs # Only to enable copilot globally, not on every project
      mc
      pandoc
      ripgrep
      shellcheck
      silver-searcher
      skim
      tmux
      yq-go
      zoxide
      zsh-autosuggestions
      zsh-completions
      zsh-forgit
      zsh-fzf-tab
      zsh-syntax-highlighting
      nix-zsh-completions
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
    direnv = {
      enable = true;
      # TODO: Enable when/if zsh is configured via home-manager
      # enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      # TODO: Enable when/if zsh is configured via home-manager
      # enableZshIntegration = true;
      changeDirWidgetCommand = "fd --hidden --type=d";
      fileWidgetCommand = "fd --hidden --type=f";
    };

    starship = {
      enable = true;
      # TODO: Enable when/if zsh is configured via home-manager
      # enableZshIntegration = true;
      settings = {
        add_newline = false;
        directory.fish_style_pwd_dir_length = 1;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
        git_metrics.disabled = false;
        git_status = {
          disabled = false;
          format = "([\\[$ahead_behind$conflicted\\]]($style))";
        };
        status = {
          disabled = false;
          symbol = "";
        };
        time.disabled = false;

        # Just disabled modules
        aws.disabled = true;
        c.disabled = true;
        gcloud.disabled = true;
        hg_branch.disabled = true;
        nodejs.disabled = true;
        package.disabled = true;
        python.disabled = true;
        rust.disabled = true;
      };
    };
  };
}

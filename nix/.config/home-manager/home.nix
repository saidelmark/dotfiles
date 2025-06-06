{ config, pkgs, ... }:

{
  home = {
    username = "mark";
    homeDirectory = "/home/mark";

    stateVersion = "24.05";

    packages = [
      pkgs.saidelman-common
    ];

    file = { };

    sessionVariables = { };


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
      };
    };
  };
}

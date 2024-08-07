{ config, pkgs, ... }:

{
  home = {

    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = "mark";
    homeDirectory = "/home/mark";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      pkgs.saidelman-common

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. If you don't want to manage your shell through Home
    # Manager then you have to manually source 'hm-session-vars.sh' located at
    # either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/mark/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      # EDITOR = "emacs";
    };

  };
  # Let Home Manager install and manage itself.
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

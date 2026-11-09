{
  pkgs,
  lib,
  config,
  ...
}:

let
  xdgConfigHome = "${config.home.homeDirectory}/.config";
  xdgDataHome = "${config.home.homeDirectory}/.local/share";
  xdgCacheHome = "${config.home.homeDirectory}/.cache";
in

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
        ];
      };

      # Store zsh config in XDG_CONFIG_HOME/zsh using absolute path
      dotDir = "${xdgConfigHome}/zsh";

      plugins = with pkgs; [
        {
          # This requires `delta` to be configured with `dark = true` (or pass is as flag)
          name = "zsh-forgit";
          src = zsh-forgit;
          file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
        }
        {
          name = "fzf-tab";
          src = zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
        {
          # This allows shell completions in direnv
          name = "zsh-completion-sync";
          src = zsh-completion-sync;
        }
        {
          name = "autopair";
          src = zsh-autopair;
          file = "share/zsh/zsh-autopair/autopair.zsh";
        }
      ];

      history = {
        append = true;
        expireDuplicatesFirst = true;
        extended = true;
        path = "${config.xdg.cacheHome}/zsh/zsh_history";
        ignoreDups = true;
        ignoreSpace = true;
        # Store history in XDG_DATA_HOME/zsh
        save = 100000;
        size = 100000;
      };

      shellAliases = {
        _ = "sudo";
        vim = "nvim";
        la = "exa -laF --icons --group-directories-first --time-style long-iso --color-scale=all";
        la-git = "exa -laF --icons --group-directories-first --time-style long-iso --git --git-ignore --color-scale=all";
      };

      shellGlobalAliases = {
        B = "| bat";
        By = "| bat --language=yaml";
        D = "| delta";
      };

      sessionVariables = {
        EDITOR = "nvim";
        MANPAGER = "nvim +Man! ";
        PASSWORD_STORE_GENERATED_LENGTH = 50;
        FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --inline-info --ansi";
        FORGIT_COPY_CMD = "xclip -selection clipboard";
        FORGIT_DIFF_PAGER = "delta --color-only";
        # XDG Base Directory variables (for other tools)
        XDG_CONFIG_HOME = "${xdgConfigHome}";
        XDG_DATA_HOME = "${xdgDataHome}";
        XDG_CACHE_HOME = "${xdgCacheHome}";
      };

      setOptions = [
        "GLOBDOTS"
      ];

      completionInit = /* zsh */ ''
        # Don't show ".." in directories' completion
        zstyle ':completion:*' special-dirs false
        zstyle ':completion:*:descriptions' format '[%d]'
        # Use XDG cache directory for completion cache
        zstyle ':completion:*' cache-path ${xdgCacheHome}/zsh/completions
      '';

      profileExtra = /* zsh */ ''
        # start ssh-agent
        unset SSH_AGENT_PID
        if [ "''${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
          export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
          gpg-connect-agent updatestartuptty /bye >/dev/null
        fi
      '';

      initContent =
        let
          # Set up fpath for Nix completions BEFORE grml-zsh-config is sourced
          # This ensures compinit picks up all completions from ~/.nix-profile
          fpathConfig = lib.mkOrder 0 /* zsh */ ''
            typeset -U path cdpath fpath manpath
            for profile in ''${(z)NIX_PROFILES}; do
              fpath+=(
                $profile/share/zsh/site-functions
                $profile/share/zsh/$ZSH_VERSION/functions
                $profile/share/zsh/vendor-completions
              )
            done
          '';
          grmlConfig = lib.mkBefore /* zsh */ ''
            source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
            prompt off
          '';
          autopairConfig = lib.mkAfter "autopair-init";
          # When I used lib.mkDefault, it was omitted from the resulting config
          defaultConfig = lib.mkOrder 1010 /* zsh */ ''
            # eval "$(devenv hook zsh)"
            # Use ^x^x to open default editor with current command in the buffer
            autoload -U edit-command-line
            zle -N edit-command-line
            bindkey '^x^x' edit-command-line

            wttr() {
              local request="https://wttr.in/''${1-$_WTTR}?mMQF"
              [ "$COLUMNS" -lt 125 ] && request+='n'
              curl -H "Accept-Language: en" --compressed "$request"
            }

            fay() {
              # fuzzy search through arch repos and install selected
              yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S
            }

            fayr() {
              # fuzzy search through arch repos and uninstall selected
              pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns
            }
          '';
        in
        lib.mkMerge [
          fpathConfig
          grmlConfig
          defaultConfig
          autopairConfig
        ];
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      changeDirWidget.command = "fd --hidden --type=d";
      fileWidget.command = "fd --hidden --type=f";
    };
    starship = {
      enable = true;
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
        golang.disabled = true;
        hg_branch.disabled = true;
        nodejs.disabled = true;
        package.disabled = true;
        python.disabled = true;
        rust.disabled = true;
      };
    };
  };

  home.packages = with pkgs; [
    zsh
    grml-zsh-config
    zsh-autosuggestions
    zsh-completions
    zsh-forgit
    zsh-fzf-tab
    zsh-syntax-highlighting
    nix-zsh-completions
  ];
}

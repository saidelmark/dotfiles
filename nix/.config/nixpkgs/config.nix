{ pkgs }:

let
  mypolybar = pkgs.polybar.override {
    alsaSupport   = true;
    githubSupport = false;
    mpdSupport    = false;
    pulseSupport  = true;
    i3Support     = true;  # it's bspwm also
    i3GapsSupport = false;
  };

in {
  packageOverrides = pkgs: with pkgs; {
    saidelman-common = pkgs.buildEnv {
      name = "saidelman-common";
      paths = [
        alttab
        bat
        bottom
        delta
        direnv
        exa
        fzf
        gdu
        htop
        jq
        nix-tree
        mc
        mypolybar
        pandoc
        shellcheck
        shfmt
        skim
        tmux
        yq-go
        zsh-autosuggestions
        zsh-completions
        zsh-fzf-tab
        zsh-syntax-highlighting
        nix-zsh-completions
      ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
    saidelman-devops = pkgs.buildEnv {
      name = "saidelman-devops";
      paths = [
        awscli
        eksctl
        kubectl
        dive
        docker-credential-helpers
        k9s
        minikube
        lazydocker
        terraform-ls
        argocd
      ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}


{
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
        kubectl-doctor
        k9s
        minikube
        kubernetes-helm
        lazydocker
        terraform-landscape
        terraform-ls
        argocd
      ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}


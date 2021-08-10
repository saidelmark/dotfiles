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
        htop
        glow
        jq
        nix-tree
        mc
        pandoc
        ripgrep
        shellcheck
        silver-searcher
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
        # aws
        awscli
        eksctl
        # kubernetes
        kubectl
        kubectl-doctor
        k9s
        minikube
        kubernetes-helm
        # docker
        dive
        docker-credential-helpers
        lazydocker
        # terraform
        terraform-landscape
        terraform-ls
        # misc
        argocd
      ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}


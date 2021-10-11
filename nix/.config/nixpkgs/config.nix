{
  packageOverrides = pkgs: with pkgs; {
    saidelman-common = pkgs.buildEnv {
      name = "saidelman-common";
      paths = [
        # alttab
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
        nodePackages.bash-language-server
        nodePackages.vim-language-server
        mc
        pandoc
        ripgrep
        rnix-lsp
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
        awscli2
        aws-iam-authenticator
        eksctl
        # kubernetes
        kubectl
        kubectl-doctor
        k9s
        minikube
        kubernetes-helm
        helmfile
        # docker
        dive
        docker-credential-helpers
        lazydocker
        # terraform
        terraform-landscape
        terraform-ls
        # misc
        argocd
        yaml-language-server
      ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}

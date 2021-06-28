# Dot't show ".." in directories' completion
zstyle ':completion:*' special-dirs false
zstyle ':completion:*:descriptions' format '[%d]'
# Always complete hidden files
setopt globdots
source ~/.nix-profile/share/zsh/plugins/nix/init.zsh
fpath=(~/.nix-profile/share/zsh/site-functions $fpath)
autoload -U compinit && compinit

# Import some aliases
source ~/.zsh/alias.sh

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --inline-info --ansi'

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

eval "$(direnv hook zsh)"

source ~/.nix-profile/share/fzf-tab/fzf-tab.plugin.zsh
source ~/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

cowsay -f three-eyes $(fortune -a) | lolcat
prompt off
eval "$(starship init zsh)"

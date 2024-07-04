# Dot't show ".." in directories' completion
zstyle ':completion:*' special-dirs false
zstyle ':completion:*:descriptions' format '[%d]'

# Use ^x^x to open default editor with current command in the buffer
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

# Always complete hidden files
setopt globdots
source ~/.nix-profile/share/zsh/plugins/nix/init.zsh
fpath=(~/.nix-profile/share/zsh/site-functions .completions $fpath)
autoload -U compinit && compinit

# Import some aliases
source ~/.zsh/alias.sh

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --inline-info --ansi'

export FORGIT_COPY_CMD='xclip -selection clipboard'
eval "$(fzf --zsh)"

source ~/.nix-profile/share/zsh/zsh-forgit/forgit.plugin.zsh

eval "$(direnv hook zsh)"

source ~/.nix-profile/share/fzf-tab/fzf-tab.plugin.zsh
source ~/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

prompt off
eval "$(starship init zsh)"

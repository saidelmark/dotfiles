bindkey -v
# Dot't show ".." in directories' completion
zstyle ':completion:*' special-dirs false
# Always complete hidden files
setopt globdots

# Import some aliases
source ~/.zsh/alias.sh

source ~/.zsh/alias.sh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --inline-info --ansi'

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

cowsay -f three-eyes $(fortune -a) | lolcat
prompt off
eval "$(starship init zsh)"

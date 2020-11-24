bindkey -v
# Dot't show ".." in directories' completion
zstyle ':completion:*' special-dirs false
# Always complete hidden files
setopt globdots

# Import some aliases
source ~/.zsh/alias.sh

export PATH="$PATH:$HOME/.cabal/bin"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

cowsay -f three-eyes $(fortune -a) | lolcat

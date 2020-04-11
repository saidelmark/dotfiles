bindkey -v

# Import some aliases
source ~/.zsh/alias.sh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

cowsay -f three-eyes $(fortune -a) | lolcat

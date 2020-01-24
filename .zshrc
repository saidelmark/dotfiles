# zsh parameter completion for the dotnet CLI

# _dotnet_zsh_complete()
# {
#   local completions=("$(dotnet complete "$words")")

#   reply=( "${(ps:\n:)completions}" )
# }

# compctl -K _dotnet_zsh_complete dotnet

# Completions for kitty
kitty + complete setup zsh | source /dev/stdin

bindkey -v

# Import some aliases
source ~/.zsh/alias.sh
export EDITOR=vim

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

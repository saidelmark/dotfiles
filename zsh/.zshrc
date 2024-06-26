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

# https://gist.github.com/peti/2c818d6cb49b0b0f2fd7c300f8386bc3
# https://github.com/NixOS/nixpkgs/issues/38991
export LOCALE_ARCHIVE_2_27=$(nix-build --no-out-link "<nixpkgs>" -A glibcLocales)/lib/locale/locale-archive
export FORGIT_COPY_CMD='xclip -selection clipboard'
eval "$(fzf --zsh)"

source ~/.nix-profile/share/zsh/zsh-forgit/forgit.plugin.zsh

eval "$(direnv hook zsh)"

source ~/.nix-profile/share/fzf-tab/fzf-tab.plugin.zsh
source ~/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

prompt off
eval "$(starship init zsh)"

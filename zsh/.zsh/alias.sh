alias _='sudo'
alias vim='nvim'

alias la='exa -laF --icons --group-directories-first --time-style long-iso --colour-scale'
alias la-git='exa -laF --icons --group-directories-first --time-style long-iso --git --git-ignore --colour-scale'

cheat() {
    # https://github.com/chubin/cheat.sh
    # `cheat tool` or `cheat language/term+with+pluses[/1..]` (append number for next result)
    # ?Q to strip comments, ?T to strip syntax hl, …
    curl cht.sh/"$@"
}

wttr() {
  local request="https://wttr.in/${1-$_WTTR}?mMQF"
  [ "$COLUMNS" -lt 125 ] && request+='n'
  # ${LANG%_*}
  curl -H "Accept-Language: en" --compressed "$request"
}

alias ghc='stack exec ghc -- '
alias ghci='stack exec ghci -- '
alias runhaskell='stack exec runhaskell -- '
fay() {
  # fuzzy search through arch repos and install selected
  # https://wiki.archlinux.org/index.php/Fzf#Arch_specific_fzf_uses
  yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S
}

fayr() {
  # fuzzy search through arch repos and uninstall selected
  pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns
}

if [ -n "$TMUX" ]; then
clean-tmux() {
  for window in $(tmux lsw -F "#{window_id}"); do
    for pane in $(tmux lsp -t "$window" -F "#{pane_id}"); do
      tmux if-shell -t "$pane" -F "#{==:#{pane_mode},copy-mode}" "send-keys -X -t $pane cancel"
      tmux send-keys -t "$pane" "c-l"
      tmux clear-history -t "$pane"
    done
  done
}
fi

if [ -n "$(which docker)" ]; then
# Delete images
drmi() {
  docker images \
    | sed 1d \
    | fzf -q "$1" -m \
    | awk '{ print $3 }' \
    | xargs -r docker rmi
}
# Clean up containers
drm() {
  docker ps -a \
    | sed 1d \
    | fzf -q "$1" -m \
    | awk '{ print $1 }' \
    | xargs -r docker rm
}
# Stop containers
dst() {
  docker ps --format="table {{.Names}}\t{{.Image}}\t{{.CreatedAt}}\t{{.Labels}}" \
    | sed 1d \
    | fzf -q "$1" -m \
    | awk '{ print $1 }' \
    | xargs -r docker stop
}
# Stop all containers
dsta() {
  docker ps --format="{{.Names}}" | xargs -r docker stop
}
fi

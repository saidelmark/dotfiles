alias _='sudo'

alias la='exa -laF --icons --group-directories-first --time-style long-iso'
alias la-git='exa -laF --icons --group-directories-first --time-style long-iso --git --git-ignore'

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

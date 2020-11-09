#!/usr/bin/bash
# Kudos https://github.com/luan/dotfiles
# choose pulseaudio sink via rofi
# changes default sink and moves all streams to that sink

# TODO: rewrite using another pulseaudio cli
# There are a lot of them, I don't want to have all of them installed

set -eu -o pipefail

TYPE="${1:-sink}"
IO="${2:-input}"

list=$(
  ponymix -t "${TYPE}" list \
    | awk '/^'"${TYPE}"'/ {s=$1" "$2;getline;gsub(/^ +/,"",$0);print s" "$0}' \
    | grep -v 'Monitor of'
)

target=$(
  echo "${list}" \
    | rofi -dmenu -i -p "Choose audio device" \
    | grep -Po '[0-9]+(?=:)'
)

ponymix -t "${TYPE}" set-default -d "${target}"

for input in $(ponymix list -t "${TYPE}-${IO}" | grep -Po '[0-9]+(?=:)'); do
  echo "$input -> ${target}"
  ponymix -t "${TYPE}-${IO}" -d "$input" move "${target}" || true
done


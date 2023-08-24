#!/bin/sh

# Arbitrary but unique message id
msgId="991049"

get_volume() {
  pulseaudio-ctl full-status | awk '{print $1}'
}

is_mute() {
  pulseaudio-ctl full-status | awk '{print $2}'
}

is_mute_input() {
  pulseaudio-ctl full-status | awk '{print $3}'
}

notify() {
  if [ "$1" = "mic" ]
  then
    if [ "$(is_mute_input)" = "yes" ]; then
      icon="/usr/share/icons/Adwaita/symbolic/status/microphone-sensitivity-muted-symbolic.svg"
    else
      icon="/usr/share/icons/Adwaita/symbolic/status/microphone-sensitivity-medium-symbolic.svg"
    fi
  else
    volume=$(get_volume)
    mute=$(is_mute)
    if [ "$mute" = "yes" ]; then
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-muted-symbolic.svg"
    elif [ "$volume" -eq "0" ]; then
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-muted-symbolic.svg"
    elif [ "$volume" -lt "40" ]; then
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-low-symbolic.svg"
    elif [ "$volume" -lt "60" ]; then
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-medium-symbolic.svg"
    elif [ "$volume" -lt "90" ]; then
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-high-symbolic.svg"
    else
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-overamplified-symbolic.svg"
    fi
  fi

  # empty message so as to show only icons
  dunstify -a "changeVolume" -u low -i "$icon" -r "$msgId" -h "int:value:$volume" ""
}

case "$1" in
  "up")
    pulseaudio-ctl up
    notify
    ;;
  "down")
    pulseaudio-ctl down
    notify
    ;;
  "mute")
    pulseaudio-ctl mute
    notify
    ;;
  "mute-input")
    pulseaudio-ctl mute-input
    notify mic
    ;;
  *)
    # Add a help function
    ;;
esac

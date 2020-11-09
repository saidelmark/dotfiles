#!/bin/sh

# Arbitrary but unique message id
msgId="991049"
time="1000"

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
      icon="/usr/share/icons/Adwaita/96x96/status/microphone-sensitivity-muted-symbolic.symbolic.png"
    else
      icon="/usr/share/icons/Adwaita/96x96/status/microphone-sensitivity-medium-symbolic.symbolic.png"
    fi
  else
    volume=$(get_volume)
    mute=$(is_mute)
    if [ "$mute" = "yes" ]; then
      icon="/usr/share/icons/Adwaita/96x96/status/audio-volume-muted-symbolic.symbolic.png"
    elif [ "$volume" -eq "0" ]; then
      icon="/usr/share/icons/Adwaita/96x96/status/audio-volume-muted-symbolic.symbolic.png"
    elif [ "$volume" -lt "40" ]; then
      icon="/usr/share/icons/Adwaita/96x96/status/audio-volume-low-symbolic.symbolic.png"
    elif [ "$volume" -lt "60" ]; then
      icon="/usr/share/icons/Adwaita/96x96/status/audio-volume-medium-symbolic.symbolic.png"
    elif [ "$volume" -lt "90" ]; then
      icon="/usr/share/icons/Adwaita/96x96/status/audio-volume-high-symbolic.symbolic.png"
    else
      icon="/usr/share/icons/Adwaita/96x96/status/audio-volume-overamplified-symbolic.symbolic.png"
    fi
  fi

  # empty message so as to show only icons
  dunstify -a "changeVolume" -u low -t "$time" -i "$icon" -r "$msgId" ""
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

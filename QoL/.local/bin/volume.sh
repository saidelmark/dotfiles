#!/bin/sh

# Arbitrary but unique message id
msgId="991049"

get_volume() {
  wpctl get-volume @DEFAULT_SINK@ | awk '{print 100 * $2}'
}

is_mute() {
  wpctl get-volume @DEFAULT_SINK@ | awk '{print $3}'
}

is_mute_input() {
  wpctl get-volume @DEFAULT_SOURCE@ | awk '{print $3}'
}

notify() {
  if [ "$1" = "mic" ]
  then
    if [ "$(is_mute_input)" = "[MUTED]" ]; then
      icon="/usr/share/icons/Adwaita/symbolic/status/microphone-sensitivity-muted-symbolic.svg"
    else
      icon="/usr/share/icons/Adwaita/symbolic/status/microphone-sensitivity-medium-symbolic.svg"
    fi
  else
    volume=$(get_volume)
    mute=$(is_mute)
    if [ "$mute" = "[MUTED]" ]; then
      echo "muted"
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-muted-symbolic.svg"
    elif [ "$volume" -eq "0" ]; then
      echo "zero volume"
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-muted-symbolic.svg"
    elif [ "$volume" -lt "40" ]; then
      echo "low volume"
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-low-symbolic.svg"
    elif [ "$volume" -lt "60" ]; then
      echo "mid volume"
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-medium-symbolic.svg"
    elif [ "$volume" -lt "90" ]; then
      echo "high volume"
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-high-symbolic.svg"
    else
      echo "too high volume"
      icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-overamplified-symbolic.svg"
    fi
  fi

  # empty message so as to show only icons
  dunstify -a "changeVolume" -u low -i "$icon" -r "$msgId" -h "int:value:$volume" ""
}

case "$1" in
  "up")
    wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+
    notify
    ;;
  "down")
    wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-
    notify
    ;;
  "mute")
    wpctl set-mute @DEFAULT_SINK@ toggle
    notify
    ;;
  "mute-input")
    wpctl set-mute @DEFAULT_SOURCE@ toggle
    notify mic
    ;;
  *)
    # Add a help function
    ;;
esac

#! /bin/sh

akvelon_hp() {
  if xrandr --listactivemonitors | grep -q 'HDMI1'; then
    # TODO: move this to xorg config
    xrandr --output HDMI1 --right-of eDP1 --primary
    bspc monitor HDMI1 -d 1 2 3 4 slack 6 mail 8
    bspc monitor eDP1 -d chat personal
    bspc wm --reorder-monitors HDMI1 eDP1
  else
    bspc monitor eDP1 -d 1 2 3 4 slack 6 mail 8 chat personal
  fi
}

desktop() {
  # TODO: move this to xorg config
  xrandr --output DisplayPort-0 --set TearFree on
  bspc monitor ^1 -d 1 2 3 4 5 6 7 8 9 10
}

default() {
  bspc monitor ^1 -d 1 2 3 4 5 6 7 8 9 10
}

case "$(hostname)" in
  "n71")       akvelon_hp ;;
  "saidelman") desktop ;;
  *)           default ;;
esac


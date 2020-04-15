#!/bin/bash
# Theme taken from rofi-menus
# Added a more sane location for screenshots,
# clipboard integration, timeout management

rofi_command="rofi -theme /usr/share/rofi-menus-git/themes/scrotmenu.rasi"

### Options ###
screen=""
area=""
window=""
# Variable passed to rofi
options="$screen\n$area\n$window"

filePattern='%Y-%m-%d_%H-%M-%S_$wx$h.png'
destination="$HOME/Pictures/screenshots"
postCommand='mv $f'

timeout=0

timeoutOptions=("3\n5\n10")

choice="$(echo -e "$options" | $rofi_command -dmenu -selected-row 1)"

if [ "$1" = "--timeout" ]
then
  timeout=${2:-5}
  echo "timeout is $timeout"
fi

case "$choice" in
  "$area")
    scrot --silent --select "$filePattern" --exec "$postCommand $destination" --delay "$timeout" --count
    ;;
  "$window")
    scrot --focused --silent "$filePattern" --exec "$postCommand $destination" --delay "$timeout" --count
    ;;
  "$screen")
    scrot --silent "$filePattern" --exec "$postCommand $destination" --delay "$timeout" --count
    ;;
  *)
    echo "Unknown command"
    ;;
esac

# Put the image to clipboard so I don't have to do it manually
fileName=$(ls -t "$destination" | head -n 1)
xclip -selection clipboard -t image/png -i "$destination/$fileName"

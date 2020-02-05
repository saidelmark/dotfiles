#!/bin/bash
# Dmenu script for editing some of my more frequently edited config files.

timeout=0

declare -a options=(" an area 
 current window 
 the whole screen ")

declare -a timeoutOptions=("3
5
10")

choice=$(echo -e "${options[@]}" | rofi -dmenu -i -p 'Make a screenshot of ')
filePattern='%Y-%m-%d_%H-%M-%S_$wx$h.png'
destination="$HOME/Pictures/screenshots"
postCommand='mv $f'

if [ "$1" ]
then
  timeout=$(echo -e "${timeoutOptions[@]}" | rofi -dmenu -i -p "With timeout (seconds)" )
fi

case "$choice" in
  ' an area ')
    scrot --silent --select "$filePattern" --exec "$postCommand $destination" --delay "$timeout" --count
    ;;
  ' current window ')
    scrot --focused --silent "$filePattern" --exec "$postCommand $destination" --delay "$timeout" --count
    ;;
  ' the whole screen ')
    scrot --silent "$filePattern" --exec "$postCommand $destination" --delay "$timeout" --count
    ;;
  *)
    echo "Unknown command"
    ;;
esac

# Put the image to clipboard so I don't have to do it manually
fileName=$(ls -t "$destination" | head -n 1)
xclip -selection clipboard -t image/png -i "$destination/$fileName"

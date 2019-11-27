#!/bin/bash
# Dmenu script for editing some of my more frequently edited config files.

timeout=0

declare -a options=(" an area 
 a window 
 the whole screen ")

declare -a timeoutOptions=("3
5
10")

choice=$(echo -e "${options[@]}" | rofi -dmenu -i -p 'Make a screenshot of ')
fileName='%Y-%m-%d_%h-%M-%S_$wx$h.png'
destination='mv $f ~/Pictures/screenshots'

if [ $1 ]
then
  timeout=$(echo -e "${timeoutOptions[@]}" | rofi -dmenu -i -p "With timeout (seconds)" )
fi

case "$choice" in
  ' an area ')
    scrot --silent --select $fileName --exec "$destination" --delay $timeout --count
    ;;
  ' current window ')
    scrot --focused --silent $fileName --exec "$destination" --delay $timeout --count
    ;;
  ' the whole screen ')
    scrot --silent $fileName --exec "$destination" --delay $timeout --count
    ;;
  *)
    echo "Unknown command"
    ;;
esac


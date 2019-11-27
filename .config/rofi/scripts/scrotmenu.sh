#!/bin/bash

rofi_command="rofi -theme themes/scrotmenu.rasi"

### Options ###
screen=""
area=""
window=""
# Variable passed to rofi
options="$screen\n$area\n$window"
fileName='%Y-%m-%d_%h-%M-%S_$wx$h.png'
destination='mv $f ~/Pictures/screenshots'

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 1)"
case $chosen in
    $screen)
        sleep 1
        scrot -q 100 --silent $fileName --exec "$destination" --delay $timeout --count
        ;;
    $area)
        scrot -q 100 --silent --select $fileName --exec "$destination" --delay $timeout --count
        ;;
    $window)
        sleep 1
        scrot -q 100 --focused --silent $fileName --exec "$destination" --delay $timeout --count
        ;;
esac


#!/bin/bash

### Options ###
power_off=""
reboot=""
lock=""
suspend=""
log_out=""
# Variable passed to rofi
options="$power_off\n$reboot\n$lock\n$suspend\n$log_out"

chosen="$(echo -e "$options" | rofi -theme-str '@import "powermenu.rasi"' -dmenu -selected-row 2)"
case $chosen in
    "$power_off")
        promptmenu --yes-command "systemctl poweroff" --query "Shutdown?"
        ;;
    "$reboot")
        promptmenu --yes-command "systemctl reboot" --query "Reboot?"
        ;;
    "$lock")
        light-locker-command -l
        ;;
    "$suspend")
        # mpc -q pause
        amixer set Master mute
        systemctl suspend
        ;;
    "$log_out")
        bspc quit
        ;;
esac


#!/bin/bash

rofi_command="rofi -theme themes/powermenu.rasi"

### Options ###
power_off=""
reboot=""
lock=""
suspend="💤"
# suspend="鈴"
log_out="🚪"
# log_out=""
# Variable passed to rofi
options="$power_off\n$reboot\n$lock\n$suspend\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $power_off)
      systemctl poweroff
      ;;
    $reboot)
      systemctl reboot
      ;;
    $lock)
      sleep 1
      scrot --silent /tmp/screen.png; \
      convert /tmp/screen.png -wave 8x32 -blur 0x3 -paint 3 /tmp/screen.png; \
      i3lock -e -f -i /tmp/screen.png
      ;;
    $suspend)
      mpc -q pause
      amixer set Master mute
      systemctl suspend
      ;;
    $log_out)
      bspc quit
      ;;
esac


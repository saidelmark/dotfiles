#!/bin/bash

CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/AC/online)

if [[ (${CAPACITY} -gt 80) && (${STATUS} -eq 1)]]
then
  dunstify -u critical -a "battery" -i "/usr/share/icons/Adwaita/96x96/legacy/battery-full-symbolic.symbolic.png" -h "int:value:$CAPACITY" "Battery is above 80%"
elif [[ (${CAPACITY} -lt 20) && (${STATUS} -eq 0)]]
then
  dunstify -u critical -a "battery" -i "/usr/share/icons/Adwaita/96x96/legacy/battery-low-symbolic.symbolic.png" -h "int:value:$CAPACITY" "Battery is below 20%"
fi

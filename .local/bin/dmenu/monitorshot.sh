#!/bin/bash

# `slop -c 0.5,0.5,0.5,0.5 -l` is a cool thing, can be used somewhere
# Get a normal selection
# read -r X Y W H G ID < <(slop -f "%x %y %w %h %g %i")

# Get the location of the mouse
XMOUSE=$(xdotool getmouselocation | awk -F "[: ]" '{print $2}')
YMOUSE=$(xdotool getmouselocation | awk -F "[: ]" '{print $4}')
# Get every monitor geometry connected to this xscreen.
MONITORS=$(xrandr | grep -o '[0-9]*x[0-9]*[+-][0-9]*[+-][0-9]*')

# Check which monitor the mouse is on.
for mon in ${MONITORS}; do
  # Parse the geometry of the monitor
  MONW=$(echo ${mon} | awk -F "[x+]" '{print $1}')
  MONH=$(echo ${mon} | awk -F "[x+]" '{print $2}')
  MONX=$(echo ${mon} | awk -F "[x+]" '{print $3}')
  MONY=$(echo ${mon} | awk -F "[x+]" '{print $4}')
  # Use a simple collision check
  if (( ${XMOUSE} >= ${MONX} )); then
    if (( ${XMOUSE} <= ${MONX}+${MONW} )); then
      if (( ${YMOUSE} >= ${MONY} )); then
        if (( ${YMOUSE} <= ${MONY}+${MONH} )); then
          # We have found our monitor!
          scrot -z -a ${MONX},${MONY},${MONW},${MONH}
          exit 0
        fi
      fi
    fi
  fi
done

# Otherwise, we must have selected a different window or geometry, so we just screenshot it normally.
maim -g"${G}" -i"${ID}" someplace.png

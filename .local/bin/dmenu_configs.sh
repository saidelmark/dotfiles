#!/bin/bash
# Dmenu script for editing some of my most frequently edited config files.

TERMINAL=kitty
declare -a options=(" bash 
 bspwm 
 compton 
 kitty 
 polybar 
 sxhkd 
 vim 
 zsh 
 quit ")

choice=$(echo -e "${options[@]}" | rofi -dmenu -i -p 'Edit a config file: ')

case "$choice" in
  ' quit ')
    echo "Program terminated."
    ;;
  ' bash ')
    exec "$TERMINAL" vim "$HOME"/.bashrc
    ;;
  ' bspwm ')
    exec "$TERMINAL" vim "$HOME"/.config/bspwm/bspwmrc
    ;;
  ' compton ')
    exec "$TERMINAL" vim "$HOME"/.config/compton/compton.conf
    ;;
  ' kitty ')
    exec "$TERMINAL" vim "$HOME"/.config/kitty/kitty.conf
    ;;
  ' polybar ')
    exec "$TERMINAL" vim "$HOME"/.config/polybar/config
    ;;
  ' sxhkd ')
    exec "$TERMINAL" vim "$HOME"/.config/sxhkd/sxhkdrc
    ;;
  ' vim ')
    exec "$TERMINAL" vim "$HOME"/.vim/vimrc
    ;;
  ' zsh ')
    exec "$TERMINAL" vim "$HOME"/.zshrc
    ;;
  *)
    echo "Unknown command"
    ;;
esac


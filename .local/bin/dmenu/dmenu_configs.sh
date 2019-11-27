#!/bin/bash
# Dmenu script for editing some of my most frequently edited config files.


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
    exec kitty vim $HOME/.bashrc
    ;;
  ' bspwm ')
    exec kitty vim $HOME/.config/bspwm/bspwmrc
    ;;
  ' compton ')
    exec kitty vim .config/compton/compton.conf
    ;;
  ' kitty ')
    exec kitty vim $HOME/.config/kitty/kitty.conf
    ;;
  ' polybar ')
    exec kitty vim $HOME/.config/polybar/config
    ;;
  ' sxhkd ')
    exec kitty vim $HOME/.config/sxhkd/sxhkdrc
    ;;
  ' vim ')
    exec kitty vim $HOME/.vim/vimrc
    ;;
  ' zsh ')
    exec kitty vim $HOME/.zshrc
    ;;
  *)
    echo "Unknown command"
    ;;
esac


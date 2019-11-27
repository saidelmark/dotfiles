#!/bin/bash
# Dmenu script for editing some of my most frequently edited config files.


declare -a options=(" bash 
 bspwm 
 kitty 
 polybar 
 st 
 sxhkd 
 vim 
 xmonad 
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
  ' kitty ')
    exec kitty vim $HOME/.config/kitty/kitty.conf
    ;;
  ' polybar ')
    exec kitty vim $HOME/.config/polybar/config
    ;;
  ' st ')
    exec kitty vim $HOME/st/config.h
    ;;
  ' sxhkd ')
    exec kitty vim $HOME/.config/sxhkd/sxhkdrc
    ;;
  ' vim ')
    exec kitty vim $HOME/.vim/vimrc
    ;;
  ' xmonad ')
    exec kitty vim $HOME/.xmonad/xmonad.hs
    ;;
  ' zsh ')
    exec kitty vim $HOME/.zshrc
    ;;
  *)
    echo "Unknown command"
    ;;
esac


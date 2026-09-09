#!/bin/bash

# Copy wallpaper
echo -e "Copy wallpaper.."
sudo mkdir -p "$HOME/wallpapers/"
sudo cp -v wall.jpg "$HOME/wallpapers/"

# Copy dotfiles
echo -e "Copy dotfiles..."
sudo mkdir -p "$HOME/.config/"
sudo cp -r -v bspwm dunst kitty picom polybar rofi sxhkd fastfetch fish "$HOME/.config/"

# Set permissions
echo -e "Set +x permissions..."
sudo chmod -v +x "$HOME/.config/bspwm/bspwmrc"
sudo chmod -v +x "$HOME/.config/sxhkd/sxhkdrc"
echo -e "✓ All set!"

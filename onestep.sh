#!/bin/bash

# Pacman Packages
PACKAGESPACMAN=(
    "bspwm"
    "sxhkd"
    "rofi"
    "udiskie"
    "udisks2"
    "polybar"
    "dunst"
    "kitty"
    "maim"
    "feh"
    "xclip"
    "fastfetch"
    "xorg-xsetroot"
    "xorg-xrandr"
    "xorg-xinit"
    "xorg-server"
    "base-devel"
    "thunar"
    "thunar-archive-plugin"
    "thunar-volman"
    "mousepad"
    "gamemode"
    "lib32-gamemode"
    "ly"
)

# Pacman Update
echo -e "Update pacman..."
pacman -Syu --noconfirm --needed > /dev/null 2>&1

# Pacman Install
echo -e "Installing utilities..."
for package in "${PACKAGESPACMAN[@]}"; do
    echo "Installing $package..."
    sudo pacman -S "$package" --noconfirm --needed > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "✓ $package installed"
    else
        echo -e "✗ Error while installing $package"
    fi
done

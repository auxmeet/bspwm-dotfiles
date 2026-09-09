#!/bin/bash

# xbps packages
PACKAGES=(
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

# xbps update
echo -e "System update..."
xbps-install -Syu

# xbps install
echo -e "Installing utilities..."
for package in "${PACKAGES[@]}"; do
    echo "Installing $package..."
    sudo xbps-install -S "$package" -yu 
    if [ $? -eq 0 ]; then
        echo -e "✓ $package installed"
    else
        echo -e "✗ Error while installing $package"
    fi
done

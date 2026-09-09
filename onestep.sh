#!/bin/bash

# repositories
REPOS=(
    "void-repo-nonfree"
    "void-repo-multilib"
    "void-repo-multilib-nonfree"
)

echo -e "Installing repositories..."
for package in "${REPOS[@]}"; do
    echo "Installing repo $package..."
    sudo xbps-install -S "$package" -yu 
    if [ $? -eq 0 ]; then
        echo -e "✓ $package installed"
    else
        echo -e "✗ Error while installing $package"
    fi
done

# xbps packages
PACKAGES=(
    "fish-shell"
    "base-devel"
    "udiskie"
    "udisks2"
    "bspwm"
    "sxhkd"
    "rofi"
    "polybar"
    "dunst"
    "kitty"
    "feh"
    "xclip"
    "maim"
    "fastfetch"
    "xorg-minimal"
    "xorg-apps"
    "xf86-video-modesetting"
    "Thunar"
    "thunar-archive-plugin"
    "thunar-volman"
    "mousepad"
    "gamemode"
)

# xbps update
echo -e "System update..."
sudo xbps-install -Syu

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

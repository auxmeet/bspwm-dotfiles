#!/bin/bash

# Info
echo -e "Paru helper needed"
echo -e "Install from git or pacman"
read -p "Continue? (pacman/git): " ans

# Git paru
if [[ "$ans" == "git" ]]; then
    echo -e "Script will install paru from git"
    echo -e "Installing paru..."
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
fi

# Pacman paru
if [[ "$ans" == "pacman" ]]; then
    echo -e "Script will install paru from pacman"
    echo -e "Installing paru..." 
    sudo pacman -S paru --noconfirm --needed > /dev/null 2>&1
fi

# Paru Packages
echo -e "Install picom-ftlabs-git and helium-browser-bin"
PACKAGESPARU=(
    "picom-ftlabs-git"
    "helium-browser-bin"
)

# Paru Update
echo -e "Update paru..."
paru -Syu --noconfirm --needed > /dev/null 2>&1

# Paru Install
for package in "${PACKAGESPARU[@]}"; do
    echo "Установка $package..."
    paru -S "$package" --noconfirm --needed > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "✓ $package installed"
    else
        echo -e "✗ Error while installing $package"
    fi
done

# Copy wallpaper
echo -e "Copy wallpaper.."
sudo mkdir -p "$HOME/wallpapers/"
sudo cp -v wall.jpg "$HOME/wallpapers/"

# Copy dotfiles
echo -e "Copy dotfiles..."
sudo mkdir -p "$HOME/.config/"
sudo cp -r -v bspwm dunst kitty picom polybar rofi sxhkd fastfetch "$HOME/.config/"

# Set permissions
echo -e "Set +x permissions..."
sudo chmod -c +x "$HOME/.config/bspwm/bspwmrc"
sudo chmod -c +x "$HOME/.config/sxhkd/sxhkdrc"

echo -e "✓ All set!"

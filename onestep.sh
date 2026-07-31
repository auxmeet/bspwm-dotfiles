#!/bin/bash
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
echo -e "${YELLOW}Installing utilities and dotfiles...${NC}"
PACKAGESPACMAN=(
    "bspwm"
    "sxhkd"
    "rofi"
    "udiskie"
    "udisks2"
    "polybar"
    "wget"
    "kitty"
    "curl"
    "maim"
    "feh"
    "xclip"
    "fastfetch"
    "xorg-xsetroot"
    "xorg-xrandr"
    "xorg-xinit"
    "xorg-server"
    "base-devel"
)
echo -e "${YELLOW}Installing paru...${NC}"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
echo -e "${YELLOW}Update pacman...${NC}"
pacman -Syu --noconfirm --noprogressbar --needed
echo -e "${YELLOW}Installing utilities...${NC}"
for package in "${PACKAGESPACMAN[@]}"; do
    echo "Installing $package..."
    sudo pacman -S "$package" --noconfirm --noprogressbar --needed
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $package installed${NC}"
    else
        echo -e "${RED}✗ Error while installing $package${NC}"
    fi
done

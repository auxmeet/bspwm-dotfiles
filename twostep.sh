#!/bin/bash
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
echo -e "${YELLOW}Installing paru...${NC}"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
echo -e "${YELLOW}Install picom-ftlabs-git and set wallpaper...${NC}"
PACKAGESPARU=(
    "picom-ftlabs-git"
)
echo -e "${YELLOW}Update paru...${NC}"
paru -Syu --noconfirm --needed
echo -e "${YELLOW}Install picom-ftlabs-git and set wallpaper...${NC}"
for package in "${PACKAGESPARU[@]}"; do
    echo "Установка $package..."
    paru -S "$package" --noconfirm --needed
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $package installed${NC}"
    else
        echo -e "${RED}✗ Error while installing $package${NC}"
    fi
done
echo -e "${YELLOW}Copy wallpaper..${NC}"
mkdir -p "$HOME/wallpapers/"
cp wall.jpg "$HOME/wallpapers/"
echo -e "${YELLOW}Copy dotfiles...${NC}"
mkdir -p "$HOME/.config/"
sudo mkdir -p bspwm dunst kitty picom polybar rofi sxhkd "$HOME/.config/"
sudo cp -r -v bspwm dunst kitty picom polybar rofi sxhkd "$HOME/.config/"
echo -e "${GREEN}✓ All set!${NC}"

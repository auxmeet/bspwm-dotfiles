#!/bin/bash
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
echo -e "Paru helper needed"
echo -e "Install from git or pacman"
read -p "Continue? (pacman/git): " ans
if [[ "$ans" == "git" ]]; then
    echo -e "${YELLOW}Script will install paru from git${NC}"
    echo -e "${YELLOW}Installing paru...${NC}"
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
fi
if [[ "$ans" == "pacman" ]]; then
    echo -e "${YELLOW}Script will install paru from pacman${NC}"
    echo -e "${YELLOW}Installing paru...${NC}" 
    sudo pacman -S paru --noconfirm --needed > /dev/null 2>&1
fi
echo -e "${YELLOW}Install picom-ftlabs-git and set wallpaper...${NC}"
PACKAGESPARU=(
    "picom-ftlabs-git"
    "helium-browser-bin"
)
echo -e "${YELLOW}Update paru...${NC}"
paru -Syu --noconfirm --needed > /dev/null 2>&1
echo -e "${YELLOW}Install picom-ftlabs-git and set wallpaper...${NC}"
for package in "${PACKAGESPARU[@]}"; do
    echo "Установка $package..."
    paru -S "$package" --noconfirm --needed > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $package installed${NC}"
    else
        echo -e "${RED}✗ Error while installing $package${NC}"
    fi
done
echo -e "${YELLOW}Copy wallpaper..${NC}"
sudo mkdir -p "$HOME/wallpapers/"
sudo cp -v wall.jpg "$HOME/wallpapers/"
echo -e "${YELLOW}Copy dotfiles...${NC}"
sudo mkdir -p "$HOME/.config/"
sudo cp -r -v bspwm dunst kitty picom polybar rofi sxhkd fastfetch "$HOME/.config/"
sudo chmod +x "$HOME/.config/bspwm/bspwmrc"
sudo chmod +x "$HOME/.config/sxhkd/sxhkdrc"
echo -e "${GREEN}✓ All set!${NC}"

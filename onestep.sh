#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Установка утилит и dotfiles...${NC}"

# Список утилит для установки (пробелы в начале удалены)
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
    "paru"
)

# Обновление пакетов
echo -e "${YELLOW}Обновление pacman...${NC}"
sudo pacman -Syu --noconfirm

# Установка утилит через официальный менеджер пакетов
echo -e "${YELLOW}Установка утилит...${NC}"
for package in "${PACKAGESPACMAN[@]}"; do
    echo "Установка $package..."
    sudo pacman -S "$package" --noconfirm
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $package установлен${NC}"
    else
        echo -e "${RED}✗ Ошибка при установке $package${NC}"
    fi
done

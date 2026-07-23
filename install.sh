#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Установка утилит и dotfiles...${NC}"

# Список утилит для установки
PACKAGES=(
    "bspwm"
    "sxhkd"
    "git"
    "rofi"
    "polybar"
    "wget"
    "kitty"
    "corl"
    "maim"
    "xclip"
    "fastfetch"
    "xorg-xsetroot"
    "paru"
)

PACKAGES2=(
    "picom-ftlabs-git"
)

# Проверка, запущен ли как root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Скрипт должен быть запущен с sudo${NC}"
   exit 1
fi

# Обновление пакетов
echo -e "${YELLOW}Обновление pacman...${NC}"
pacman -Syu --noconfirm

# Установка утилит
echo -e "${YELLOW}Установка утилит...${NC}"
for package in "${PACKAGES[@]}"; do
    echo "Установка $package..."
    pacman -S "$package" --noconfirm
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $package установлен${NC}"
    else
        echo -e "${RED}✗ Ошибка при установке $package${NC}"
    fi
done

echo -e "${YELLOW}Установка утилит...${NC}"
for package in "${PACKAGES[@]}"; do
    echo "Установка $package2..."
    paru -S "$package2" --noconfirm
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $package2 установлен${NC}"
    else
        echo -e "${RED}✗ Ошибка при установке $package2${NC}"
    fi
done

# Копирование dotfiles
echo -e "${YELLOW}Копирование конфигов...${NC}"
cp bpswm ~/.config/bspwm/
cp dunst ~/.config/dunst/
cp polybar ~/.config/polybar/
cp picom ~/.config/picom/
cp sxhkd ~/.config/sxhkd/
cp kitty ~/.config/kitty/
cp fastfetch ~/.config/fastfetch/
cp rofi ~/.config/rofi/
# Добавьте свои файлы

echo -e "${GREEN}✓ Все готово!${NC}"

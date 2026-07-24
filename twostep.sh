#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Установка picom и обоев...${NC}"

PACKAGESPARU=(
    "picom-ftlabs-git"
)

echo -e "${YELLOW}Обновление paru...${NC}"
paru -Syu --noconfirm

echo -e "${YELLOW}Установка утилиты picom-ftlabs-git и обоев${NC}"
for package in "${PACKAGESPARU[@]}"; do
    echo "Установка $package..."
    paru -S "$package" --noconfirm
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $package установлен${NC}"
    else
        echo -e "${RED}✗ Ошибка при установке $package${NC}"
    fi
done

echo -e "${YELLOW}Копирование обоев..${NC}"
mkdir -p "$HOME/wallpapers/"
cp wall.jpg "$HOME/wallpapers/"

echo -e "${YELLOW}Копирование конфигов...${NC}"
mkdir -p "$HOME/.config/"
sudo cp -r -v bspwm dunst kitty picom polybar rofi sxhkd "$HOME/.config/"
echo -e "${GREEN}✓ Все готово!${NC}"

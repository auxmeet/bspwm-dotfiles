#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Установка утилиты picom и обоев${NC}"

PACKAGES=(
    "picom-ftlabs-git"
)

# Обновление пакетов
echo -e "${YELLOW}Обновление pacman...${NC}"
paru-Syu --noconfirm

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

echo -e "${YELLOW}Копирование обоев..${NC}"
mkdir -p ~/wallpapers/
cp wall.jpg ~/wallpapers/

echo -e "${GREEN}✓ Все готово!${NC}"

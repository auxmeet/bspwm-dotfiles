#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Установка обоев${NC}"

echo -e "${YELLOW}Копирование обоев..${NC}"
mkdir -p ~/wallpapers/
cp wall.jpg ~/wallpapers/

echo -e "${GREEN}✓ Все готово!${NC}"

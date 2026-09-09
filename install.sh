#!/bin/bash
# Stop execution if any command fails
set -e

# ==========================================
# 1. DEFINING ARRAYS (REPOS & PACKAGES)
# ==========================================

REPOS=(
    "void-repo-nonfree"
    "void-repo-multilib"
    "void-repo-multilib-nonfree"
)

# Core system utilities (Strictly configured with fish-shell and xinit)
SYSTEM_PACKAGES=(
    "fish-shell"
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
    "xinit"          # Необходим для ручного запуска X-сервера через startx
    "xf86-video-modesetting"
    "Thunar"
    "thunar-archive-plugin"
    "thunar-volman"
    "mousepad"
    "gamemode"
)

# Compiling tools and source code dependencies (Verified -devel suffixes)
BUILD_DEPS=(
    "base-devel"
    "meson"
    "ninja"
    "cmake" 
    "libev-devel"
    "xcb-util-renderutil-devel"
    "xcb-util-image-devel"
    "pixman-devel"
    "pkg-config"
    "uthash"
    "pcre2-devel"
    "dbus-devel"
    "glu-devel"
    "libconfig-devel"
    "libepoxy-devel"
)

# ==========================================
# 2. SYSTEM PACKAGES CONFIGURATION
# ==========================================

echo "==> Step 1: Adding non-free and multilib repositories..."
sudo xbps-install -Sy "${REPOS[@]}"

echo "==> Step 2: Performing full system upgrade..."
sudo xbps-install -Syu

echo "==> Step 3: Installing main system utilities and xinit..."
sudo xbps-install -y "${SYSTEM_PACKAGES[@]}"

echo "==> Step 4: Installing software compilation dependencies..."
sudo xbps-install -y "${BUILD_DEPS[@]}"

# ==========================================
# 3. COMPILING FROM SOURCE
# ==========================================

echo "==> Step 5: Cloning and building Picom (FTLabs animations fork)..."
rm -rf picom
git clone --depth=1 https://github.com/r0-zero/picom
cd picom
meson setup build --buildtype=release --prefix=/usr
ninja -C build
sudo ninja -C build install
cd ..

# ==========================================
# 4. USER DOTFILES & WALLPAPERS
# ==========================================

echo "==> Step 6: Structuring user environment paths..."
mkdir -p "$HOME/wallpapers/"
mkdir -p "$HOME/.config/"

echo "==> Step 7: Copying wallpapers and configuration files..."
if [ -f "wall.jpg" ]; then
    cp -v wall.jpg "$HOME/wallpapers/"
else
    echo "Warning: wall.jpg not found in current directory, skipping."
fi

DOTFILES=(bspwm dunst kitty picom polybar rofi sxhkd fastfetch fish)
for folder in "${DOTFILES[@]}"; do
    if [ -d "$folder" ]; then
        cp -r -v "$folder" "$HOME/.config/"
    else
        echo "Warning: Configuration folder '$folder' not found in current directory, skipping."
    fi
done

echo "==> Step 8: Granting executable permissions to core configs..."
if [ -f "$HOME/.config/bspwm/bspwmrc" ]; then
    chmod -v +x "$HOME/.config/bspwm/bspwmrc"
fi
if [ -f "$HOME/.config/sxhkd/sxhkdrc" ]; then
    chmod -v +x "$HOME/.config/sxhkd/sxhkdrc"
fi

# ==========================================
# 5. POST-INSTALL CONFIGURATION
# ==========================================

echo "==> Step 9: Creating .xinitrc configuration..."
# Скрипт создаёт файл инициализации X-сессии, который запускает sxhkd и bspwm
cat << 'EOF' > "$HOME/.xinitrc"
#!/bin/sh

# Запуск горячих клавиш в фоне
sxhkd &

# Запуск оконного менеджера bspwm
exec bspwm
EOF

chmod +x "$HOME/.xinitrc"

echo "==> Step 10: Setting Fish shell as default..."
if ! grep -q "/usr/bin/fish" /etc/shells; then
    echo "/usr/bin/fish" | sudo tee -a /etc/shells
fi
chsh -s /usr/bin/fish "$USER"

echo -e "\n✓ SUCCESS: System build completed! Please reboot your machine."
echo "After rebooting, log in to your TTY terminal and type 'startx' to enter BSPWM."

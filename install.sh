#!/bin/bash
# Stop execution if any command fails
set -e

REPOS=(
    "void-repo-nonfree"
    "void-repo-multilib"
    "void-repo-multilib-nonfree"
)

# Core system utilities and Xorg server components
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
    "xf86-video-modesetting"
    "Thunar"
    "thunar-archive-plugin"
    "thunar-volman"
    "mousepad"
    "gamemode"
)

# Compiling tools and source code dependencies
BUILD_DEPS=(
    "base-devel"
    "meson"
    "ninja"
    "cmake" 
    "zig"
    "libev-devel"
    "xcb-util-renderutil-development"
    "xcb-util-image-development"
    "pixman-development"
    "pkg-config"
    "uthash"
    "pcre2-development"
    "dbus-development"
    "glu-development"
    "libconfig-development"
    "libepoxy-development"
    "pam-development"
)

# ==========================================
# 2. SYSTEM PACKAGES CONFIGURATION
# ==========================================

echo "==> Step 1: Adding non-free and multilib repositories..."
sudo xbps-install -Sy "${REPOS[@]}"

echo "==> Step 2: Performing full system upgrade..."
sudo xbps-install -Syu

echo "==> Step 3: Installing main system utilities..."
sudo xbps-install -y "${SYSTEM_PACKAGES[@]}"

echo "==> Step 4: Installing software compilation dependencies..."
sudo xbps-install -y "${BUILD_DEPS[@]}"

# ==========================================
# 3. COMPILING FROM SOURCE
# ==========================================

echo "==> Step 5: Cloning and building Picom (FTLabs animations fork)..."
git clone https://github.com
cd picom
meson setup build --buildtype=release --prefix=/usr
ninja -C build
sudo ninja -C build install
cd ..

echo "==> Step 6: Cloning and building Ly Display Manager..."
git clone https://github.com
cd ly
zig build installexe -Dinit_system=runit

# Safely disabling default tty2 agetty to clear path for Ly
sudo unlink /var/service/agetty-tty2 || true
sudo touch /etc/sv/agetty-tty2/down || true

# Linking Ly binary to Runit services
sudo ln -s /etc/sv/ly /var/service/
cd ..

# ==========================================
# 4. USER DOTFILES & WALLPAPERS
# ==========================================

echo "==> Step 7: Structuring user environment paths..."
mkdir -p "$HOME/wallpapers/"
mkdir -p "$HOME/.config/"

echo "==> Step 8: Copying wallpapers and configuration files..."
cp -v wall.jpg "$HOME/wallpapers/"
cp -r -v bspwm dunst kitty picom polybar rofi sxhkd fastfetch fish "$HOME/.config/"

echo "==> Step 9: Granting executable permissions to core configs..."
chmod -v +x "$HOME/.config/bspwm/bspwmrc"
chmod -v +x "$HOME/.config/sxhkd/sxhkdrc"

echo -e "\n✓ SUCCESS: System build completed. Please reboot to initialization environment."

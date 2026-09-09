#!/bin/bash
# Stop execution if any command fails
set -e 

# 1. Corrected package list for Void Linux (+ added zig and pam-development)
BUILDUTILS=(
    "base-devel"
    "meson"
    "ninja"
    "cmake" 
    "zig"
    "libev-development"
    "xcb-util-renderutil-development"
    "xcb-util-image-devel"
    "pixman-development"
    "pkg-config"
    "uthash"
    "pcre2-development"
    "dbus-development"
    "glu-development"
    "libconfig-development"
    "libepoxy-development"
    "pam-development" # Required for Ly display manager authentication
)

echo "Updating repositories and installing build dependencies..."
sudo xbps-install -Syu
sudo xbps-install -y "${BUILDUTILS[@]}"

# 2. Build Picom (Fixed directory name after git clone)
echo "Cloning and building Picom..."
git clone https://github.com
cd picom
meson setup build --buildtype=release --prefix=/usr
ninja -C build
sudo ninja -C build install
cd ..

# 3. Build Ly (Rewritten to use the modern Zig build system and correct Runit integration)
echo "Cloning and building Ly Display Manager..."
git clone https://github.com
cd ly
zig build installexe -Dinit_system=runit

# Safely disable agetty on tty2 to avoid conflicts with Ly
sudo unlink /var/service/agetty-tty2 || true
sudo touch /etc/sv/agetty-tty2/down || true

# Enable Ly service in runit
sudo ln -s /etc/sv/ly /var/service/
cd ..

# 4. Copy wallpaper (Executed WITHOUT sudo so you own the files)
echo "Copying wallpaper..."
mkdir -p "$HOME/wallpapers/"
cp -v wall.jpg "$HOME/wallpapers/"

# 5. Copy dotfiles (Executed WITHOUT sudo to prevent permission lockouts)
echo "Copying configuration files..."
mkdir -p "$HOME/.config/"
cp -r -v bspwm dunst kitty picom polybar rofi sxhkd fastfetch fish "$HOME/.config/"

# 6. Set executable permissions (WITHOUT sudo)
echo "Setting executable permissions on startup scripts..."
chmod -v +x "$HOME/.config/bspwm/bspwmrc"
chmod -v +x "$HOME/.config/sxhkd/sxhkdrc"

echo -e "\n✓ All utilities, window manager components, and dotfiles successfully installed!"

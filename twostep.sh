#!/bin/bash
# utils for build
BUILDUTILS=(
    "base-devel"
    "meson"
    "ninja"
    "cmake" 
    "libev-devel"
    "xcb-util-renderutil-devel"
    "xcb-util-image-devel"
    "pixman-devel"
    "pkgconfig"
    "uthash"
    "pcre2-devel"
    "dbus-devel"
    "glu-devel"
    "libconfig-devel"
    "libepoxy-devel"
)

echo -e "Installing utils..."
for package in "${BUILDUTILS[@]}"; do
    echo "Installing $package..."
    sudo xbps-install -S "$package" -yu > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "✓ $package installed"
    else
        echo -e "✗ Error while installing $package"
    fi
done

# Build Picom
git clone https://github.com/r0-zero/picom
cd picom-ftlabs
meson setup build --buildtype=release --prefix=/usr
ninja -C build
sudo ninja -C build install
cd ..

# Build
git clone https://github.com/cylgom/ly.git
cd ly
make github
make
sudo make install
sudo ln -s /etc/sv/ly-runit-service /var/service/
sudo rm /var/service/agetty-tty2
cd ..

# Copy wallpaper
echo -e "Copy wallpaper.."
sudo mkdir -p "$HOME/wallpapers/"
sudo cp -v wall.jpg "$HOME/wallpapers/"

# Copy dotfiles
echo -e "Copy dotfiles..."
sudo mkdir -p "$HOME/.config/"
sudo cp -r -v bspwm dunst kitty picom polybar rofi sxhkd fastfetch fish "$HOME/.config/"

# Set permissions
echo -e "Set +x permissions..."
sudo chmod -v +x "$HOME/.config/bspwm/bspwmrc"
sudo chmod -v +x "$HOME/.config/sxhkd/sxhkdrc"
echo -e "✓ All set!"

# bspwm-dotfiles
## For install my dotfiles and stuff type this in your terminal:
 ```bash
git clone https://github.com/auxmeet/bspwm-dotfiles.git 
cd bspwm-dotfiles
chmod +x onestep.sh
chmod +x twostep.sh
sudo ./onestep.sh
./twostep.sh
```

## !! Use only [CachyOS](https://cachyos.org/download/) or other Arch-based !!
## Also thanks fot support @iromenero

# How to use Fastfetch
`fastfetch --config ~/.config/fastfetch/fastfetch.jsonc`

# Keybinds
## Applications
- `Super + Return` or `Super + (Enter)`: Open Kitty terminal emulator.
- `Super + D`: Open Rofi application launcher menu.
- `Super + T`: Open Thunar (XFCE) file manager.
- `Super + H`: Opens the Helium web browser.

## Window Management
- `Super + Q`: Closes the currently focused window (node).
- `Super + {T, F, S}`: Changes the window state (Tiled, Fullscreen, or Floating).

## Focus & Navigation
- `Super + {Left, Down, Up, Right}`: Changes window focus to the neighboring window in that direction.
- `Super + Shift + {Left, Down, Up, Right}`: Swaps the position of the focused window with the window in that direction.
- `Super + {1-9, 0}`: Switches to the selected workspace (1 to 10).
- `Super + Shift + {1-9, 0}`: Sends the focused window to the selected

## System & Media
- `Super + R`: Reloads the bspwm configuration and restarts sxhkd to apply changes.
- `Super + P`: Exits and quits the bspwm session.
- `XF86AudioRaiseVolume` or `FN + F3`: Increases the volume by 5% using WirePlumber.
- `XF86AudioLowerVolume` or `FN + F2`: Decreases the volume by 5%.
- `XF86AudioMute` or `FN + F4`: Mutes or unmutes the default audio device.

## Screenshots
- `Super + Shift + D`: Takes a screenshot of the entire screen, copies it to the clipboard, and deletes the temporary file.
- `Super + Shift + S`: Allows you to select an area or window to screenshot a region, copies it to the clipboard, and deletes the temporary file.

# Packages list 
## Installed with pacman:
- bspwm - X11 Window Manager.

- sxhkd - Simple X Hot Key Daemon.
 
- rofi - Application launcher.

- udiskie - Auto mount disks or USB Sticks.

- udisks2 - Background service to manage storage devices.

- polybar - Customizable bar.

- dunst - Notification daemon.

- kitty - Fast GPU Terminal.

- maim - Command-Line utility used to capture screenshots.

- feh - Fast lightweight image viewer and wallpaper.

- xclip - Command-line tool that makes copy your screenshot.

- fastfetch - Command-Line Utility that Displays Hardware Information.

- xorg-xsetroot - Command-Line tool used to customize cursor on an X11 Display Server.

- xorg-xrandr - Command-Line utility for X Window System lets you change screen resolutions and refresh rates.

- xorg-xinit - Program used to manually start Xorg Display Server.

- xorg-server - Display server to manage the Graphical User Interface.

- base-devel - Package Group used for Compiling and Building Software.

- gamemode - Background program and library tool if you play games on your computer this program turn performance boosts.

- lib32-gamemode - Is 32-bit version of gamemode.
  
- ly - Lightweight command-line Display Manager.

## Installed with git:
- paru - A Feature-Packed Helper and Wrapper for Pacman.

## Installed with paru:
- picom-ftlabs-git - A Fork of Picom that support animations.

# Wallpaper
![wall.jpg](wall.jpg)

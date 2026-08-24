#!/usr/bin/env bash
set -e
LINE="-------------------------------------------"

export PATH="$HOME/.local/bin:$PATH"

if ! command -v pacman &>/dev/null; then
    echo "This script is only for Arch based systems. Exiting..."
    echo "$LINE"
    exit 1
fi

echo "Arch based system found!"

if ! command -v git &>/dev/null; then
    echo "Installing git..."
    sudo pacman -S --noconfirm git
    echo "git installed successfully!"
else
    echo "git is already installed!"
fi

# Setup AUR helper
if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si

    cd ..
    rm -rf yay-bin

    yay -Y --gendb

    echo "AUR helper installed!"
else
    echo "AUR helper already installed!"
fi

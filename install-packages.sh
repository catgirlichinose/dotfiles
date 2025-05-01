#!/bin/bash

# Define color variables for output
BLUE='\033[34m'
NOTBLUE='\033[0m'

# Function to print messages in blue
function print_blue() {
    echo -e "${BLUE}$1${NOTBLUE}"
}

if pacman -Qi paru > /dev/null 2>&1; then
    echo "paru already installed, skipping."
else
    # Install paru from AUR
    print_blue "\nInstalling paru
    "
    git clone https://aur.archlinux.org/paru.git
    cd paru || { echo "Failed to enter 'paru' directory"; exit 1; }
    makepkg -si --noconfirm
    cd ..
fi

# Define the list of packages
packages=(
    hyprland
    hyprpaper
    eza
    waybar
    rofi
    nautilus
    kitty
    fastfetch
    zoxide
    fzf
    firefox
    oh-my-posh
    otf-codenewroman-nerd
    vesktop
    neovim
    stow
    zsh
)

# Change default shell to zsh
if $SHELL != zsh; do
    chsh
fi

# Install packages if not already installed
for package in "${packages[@]}"; do
    if pacman -Qi "$package" > /dev/null 2>&1; then
        echo "$package is already installed, skipping."
    else
        paru -S --noconfirm "$package"
    fi
done

# Check if current directory is 'dotfiles' (case-insensitive)
if [[ "$(pwd)" == *dotfiles* ]]; then
    # Remove specific files if they exist
    rm -f install-packages.sh README.md
    # Use stow to manage dotfiles
    stow .
else
    echo 'Run "stow ." in the dotfiles folder'
fi

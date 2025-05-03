#!/bin/bash

# Check if git and/or networkmanager

# Check if Git is installed
if pacman -Qi git > /dev/null 2>&1; then
    # Git is installed
    is_git_installed=1
else
    # Git is NOT installed
    is_git_installed=0
fi

# Check if NetworkManager is installed
if pacman -Qi networkmanager > /dev/null 2>&1; then
    if systemctl is-active --quiet NetworkManager; then
        # NetworkManager is installed and running
        is_nm_installed=1
    else
        # NetworkManager is installed but not running
        is_nm_installed=2
    fi
else
    # NetworkManager is NOT installed
    is_nm_installed=0
fi
    
# Define color variables for output
RED='\e[31m'
GREEN='\e[32m'
BLUE='\e[34m'
BOLD='\e[1m'
RESET='\e[0m'

epic_print_function() {
    case $2 in
        green)
            echo -e "\n${BOLD}${GREEN}==>${RESET} ${BOLD}$1${RESET}";;
        blue)
            echo -e "\n${BOLD}${BLUE}==>${RESET} ${BOLD}$1${RESET}";;
        red)
            echo -e "\n${BOLD}${RED}==>${RESET} ${BOLD}$1${RESET}";;
    esac
}

install_paru() {
    if pacman -Qi paru > /dev/null 2>&1; then
        epic_print_function "paru already installed, skipping." "blue"
    else
        # Install paru from AUR
        epic_print_function "Installing paru
        " "green"
        git clone https://aur.archlinux.org/paru.git
        pushd paru || { echo "Failed to enter 'paru' directory"; exit 1; }
        makepkg -si --noconfirm
        popd
        rm -r paru/
    fi
}

case $is_git_installed in
    1)
        :;;
    0)
        sudo pacman -S --noconfirm git;;
esac

case $is_nm_installed in
    0)
        sudo pacman -S --noconfirm networkmanager
        sudo systemctl enable --now NetworkManager;;
    1)
        :;;
    2)
        sudo systemctl enable --now NetworkManager;;
esac

install_paru

# Define the list of packages
packages=(
    # hyprland
    hyprland-git
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
    unzip
)

epic_print_function "Installing packages" "green"
# Install packages if not already installed
for package in "${packages[@]}"; do
    if pacman -Qi "$package" > /dev/null 2>&1; then
        epic_print_function "$package is already installed, skipping." "blue"
    else
        paru -S --noconfirm "$package"
    fi
done

# Check if current directory is 'dotfiles' (case-insensitive)
if [[ "$(pwd)" == *dotfiles* ]]; then
    # Remove specific files if they exist
    rm -f install-packages.sh README.md
    # Use stow to manage dotfiles
    if stow . --dotfiles > /dev/null 2>&1; then
        epic_print_function 'Dotfiles successfully stowed' "blue"
    else
        rm -r ~/.config/
        stow . --dotfiles
    fi
fi

if [[ "$SHELL" != "/bin/zsh" ]]; then
    chsh -s /bin/zsh
fi

reboot

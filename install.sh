#!/bin/bash
    
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
        rm -fr paru/
    fi
}

install_paru

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
    # Use stow to manage dotfiles
    if stow . --dotfiles > /dev/null 2>&1; then
        epic_print_function 'Dotfiles successfully stowed' "blue"
    else
        rm -fr ~/.config/
        stow . --dotfiles
    fi
fi

if [[ "$SHELL" != "/bin/zsh" ]]; then
    chsh -s /bin/zsh
fi

reboot

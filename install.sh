#!/bin/bash

# Define color variables for output
GREEN='\e[32m'
BLUE='\e[32m'
BOLD='\e[1m'
RESET='\e[0m'

epic_print_function_green() {
    echo -e "\n${GREEN}==>${RESET} ${BOLD}$1${RESET}"
}

epic_print_function_blue() {
    echo -e "\n${BLUE}==>${RESET} ${BOLD}$1${RESET}"
}

# Function to print messages in blue

if pacman -Qi paru > /dev/null 2>&1; then
    epic_print_function_blue "paru already installed, skipping."
else
    # Install paru from AUR
    epic_print_function_green "\n${green_arrow}${bold}Installing paru${normal}
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

epic_print_function_green "Installing packages"
# Install packages if not already installed
for package in "${packages[@]}"; do
    if pacman -Qi "$package" > /dev/null 2>&1; then
        epic_print_function_blue "$package is already installed, skipping."
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
        epic_print_function_blue 'Dotfiles successfully stowed'
    else
        rm -fr ~/.*
        rm -fr ~/.*/
        stow . --dotfiles
fi

echo "${BOLD}To apply changes, reboot the system.${RESET}"

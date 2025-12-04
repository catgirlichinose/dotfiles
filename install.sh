#!/bin/bash
    
# Define color variables for output
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
BOLD='\e[1m'
RESET='\e[0m'

epic_print_function() {
    case $2 in
        success)
            echo -e "\n${BOLD}${GREEN}==>${RESET} ${BOLD}$1${RESET}";;
        info)
            echo -e "\n${BOLD}${BLUE}==>${RESET} ${BOLD}$1${RESET}";;
        warning)
            echo -e "\n${BOLD}${YELLOW}==>${RESET} ${BOLD}$1${RESET}";;
        error)
            echo -e "\n${BOLD}${RED}==>${RESET} ${BOLD}$1${RESET}";;
    esac
}

# Check whether the user is connected
if ping -c 1 google.com > /dev/null 2>&1; then
    :
else
    epic_print_function "Connection not available, the installer won't proceed" error
    exit
fi

# Check if Paru is installed
if pacman -Qi paru > /dev/null 2>&1; then
    epic_print_function "paru already installed, skipping." info
else
    # Clone, build and install paru from the AUR
    epic_print_function "Installing paru" info
    git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm 
    cd - && rm -fr paru/
    epic_print_function "Paru has been successfully installed" success
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
    zsh
    unzip
)

epic_print_function "Installing packages" info
# Install packages if not already installed
for package in "${packages[@]}"; do
    if pacman -Qi "$package" > /dev/null 2>&1; then
        epic_print_function "$package is already installed, skipping." info
    else
        paru -S --noconfirm "$package"
    fi
done

# Check if current directory is 'dotfiles'
if [[ "$(pwd)" == *dotfiles* ]]; then
    cp -r .config/* ~/.config/
    cp -r .wallpaper/ ~/
    cp .zshrc ~/
    epic_print_function "Configs successfully copied" success
else
    epic_print_function "Configs couldn't be found, are you in the right folder?" error
    touch ~/.zshrc
fi

if [[ "$SHELL" != "/bin/zsh" ]]; then
    chsh -s /bin/zsh
fi

reboot

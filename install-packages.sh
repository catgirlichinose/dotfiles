BLUE='\033[34m'
NOTBLUE='\033[0m'

printf ${BLUE}'\nInstalling YAY\n\n'${NOTBLUE}

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

printf ${BLUE}'\nInstalling packages\n\n'${NOTBLUE}

sudo pacman -Sy hyprland hyprpaper eza waybar rofi nautilus kitty fastfetch zoxide fzf firefox 
yay -S oh-my-posh otf-codenewroman-nerd vesktop

cd ~/dotfiles
rm -f install-packages.sh README.md
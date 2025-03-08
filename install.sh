BLUE='\033[34m'
NOTBLUE='\033[0m'

printf ${BLUE}'\nInstalling YAY\n\n'${NOTBLUE}

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

printf ${BLUE}'\nInstalling necessary packages\n\n'${NOTBLUE}
sudo pacman -Sy hyprland hyprpaper eza waybar rofi nautilus kitty fastfetch zoxide fzf firefox 
yay -S oh-my-posh otf-codenewroman-nerd vesktop

printf ${BLUE}'\nInstalling dotfiles\n\n'${NOTBLUE}

mv config .config
mv mozilla .mozilla
mv wallpaper .wallpaper 
mv zshrc .zshrc

rm -rf ~/.config/
rm -rf ~/.zshrc
cd ~/dotfiles
mv .* ~

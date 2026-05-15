# ⚠️⚠️ WARNING ⚠️⚠️

**TLDR: I think developing this config further would be a waste of my (and everyone's) time, i'll stop updating this repo and upload bits that i ACTUALLY USE on another repo**

As of adventuring more and more into my Linux journey, i've been mostly ignoring this dotfiles repo due to my progessively growing disinterest in hyprland and everything around it (INCLUDING the community).
I think it was fun at first, but trying to configure an environment that i have no interest in using and that probably wouldn't help my workflow much is stupid, especially since all of this was built exclusively using virtual machines rather than actual hardware.
Things to note:
- While i originally used AI for the install script and since then became less reliant on AI tools, this helped me slightly develop my bash scripts
- I still somewhat use catppuccin as a theme, i really like it honestly
- The zsh and fastfetch configs are somewhat embedded into my daily setup but somewhat updated, so i might add them on a new repo
- Working with GTK is a pain in the ass honestly i don't recommend it to anyone
- hamburger.
- omarchy is a shit distro btw

## My Hatsune Miku themed hyprland dotfiles (a lot of stuff might change)

Includes:
- Catppuccin themed GTK and Firefox theme (GTK theme made with gradience)
- Hyprland and Hyprpaper configuration made by me
- Vesktop client with catppuccin theme
- Kitty + Fastfetch + zsh configuration (based on [zenshrc](https://github.com/dreamsofautonomy/zensh/blob/))
- Barely complete Waybar configuration (yeah that's probably gonna be worked on)

## Installation

**Note: These dotfiles are meant to be installed on a fresh Arch Linux, stuff COULD and most likely WILL break**

Clone the repo in the home directory

    git clone https://github.com/catgirlichinose/dotfiles.git

and run the installer

    ./install.sh 
    
## TODO

- [x] fix the poorly made install script
- [ ] actually configure waybar properly
- [ ] find a way to automatically setup firefox extensions  
- [ ] probably format everything a bit better
- [ ] make a miku themed sddm theme
- [ ] maybe add more wallpapers????

## Credits
- [dreamsofautonomy](https://github.com/dreamsofautonomy) and his zshrc configuration (from which i "based" mine)

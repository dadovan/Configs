#!/bin/sh

###################################################################################################
# Manual Steps:
# curl https://raw.githubusercontent.com/dadovan/Configs/master/Arch/setup.sh > ~/setup.sh
# chmod +x ~/setup.sh
# ./setup.sh
# rm ~/setup.sh
#
###################################################################################################

# Base

sudo apt update
sudo apt upgrade

# Configs

mkdir ~/.config
mkdir ~/git
cd ~/git
git clone https://github.com/dadovan/Configs.git
cp -r ~/git/Configs/.config/tmux ~/.config/
cp -r ~/git/Configs/.config/vim ~/.config/
cd ~

echo "source ~/.config/zsh/.zshrc" > ~/.zshrc
echo "source-file ~/.config/tmux/.tmux.conf" > ~/.tmux.conf

# Zsh

sudo apt install zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.config/zsh/zsh-completions
cp -r ~/git/Configs/.config/zsh ~/.config/
chsh -s /bin/zsh

# Starship prompt
curl -sS https://starship.rs/install.sh | sh
cp ~/git/Configs/.config/starship.toml ~/.config

# Install Cascadia Cove Nerd Font
sudo apt install fontconfig
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip
mkdir -p ~/.fonts
unzip CascadiaCode.zip -d ~/.fonts
fc-cache -fv

###################################################################################################
# Apps

sudo apt install exa                        # ls replacement @ https://the.exa.website/
sudo apt install fzf                        # Command-line fuzzy finder @ https://github.com/junegunn/fzf
sudo apt install mc                         # Midnight Commander
sudo apt install micro                      # Micro editor @ https://micro-editor.github.io/
sudo apt install ncdu                       # NCurses Disk Usage @ https://dev.yorhel.nl/ncdu
sudo apt install neofetch
# sudo apt install ranger                   # Ranger file manager @ https://ranger.github.io/
sudo apt install ripgrep                    # Better grep @ https://github.com/BurntSushi/ripgrep
# sudo apt install stacer                   # Sytem monitoring and config @ https://oguzhaninan.github.io/Stacer-Web/

###################################################################################################
# Apps not in apt or too old in apt (Ubuntu 20.04 is the default, Ubuntu 22.04 hangs frequently)
# Double-check for latest versions
mkdir -p ~/temp

# Install Kitty and pre-reqs
# https://github.com/danielbisar/settings/blob/main/guides/kitty-on-windows-with-wsl2.md
sudo apt install x11-apps
sudo apt install libwayland-egl1-mesa
mkdir -p ~/.config/kitty
cp -r ~/git/Configs/.config/kitty ~/.config/
#sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# btop op replacement @ https://github.com/aristocratos/btop
wget -O ~/temp/btop.tbz https://github.com/aristocratos/btop/releases/latest/download/btop-x86_64-linux-musl.tbz
sudo tar xf ~/temp/btop.tbz -C /usr/local bin/btop

# bat (improved cat) @ https://github.com/sharkdp/bat
wget -O ~/temp/bat-musl_0.21.0_amd64.deb https://github.com/sharkdp/bat/releases/download/v0.21.0/bat-musl_0.21.0_amd64.deb
sudo apt install ~/temp/bat-musl_0.21.0_amd64.deb

https://github.com/sharkdp/bat/releases/download/v0.21.0/bat-musl_0.21.0_amd64.deb

# Git UI @ https://github.com/extrawurst/gitui
wget -O ~/temp/gitui-linux-musl.tar.gz https://github.com/extrawurst/gitui/releases/download/v0.20.1/gitui-linux-musl.tar.gz
untar ~/temp/gitui-linux-musl.tar.gz
sudo mv ~/temp/gitui /usr/local/bin

# Git Delta @ https://github.com/dandavison/delta
wget -O ~/temp/git-delta-musl_0.13.0_amd64.deb https://github.com/dandavison/delta/releases/download/0.13.0/git-delta-musl_0.13.0_amd64.deb
sudo apt install ~/temp/git-delta-musl_0.13.0_amd64.deb

# Logfile Navigator @ https://lnav.org/
wget -O ~/temp/lnav-0.10.1-musl-64bit.zip https://github.com/tstack/lnav/releases/download/v0.10.1/lnav-0.10.1-musl-64bit.zip
unzip ~/temp/lnav-0.10.1-musl-64bit.zip -d ~/.local
sudo ln -s ~/.local/lnav-0.10.1/lnav /usr/local/bin

# tldr client @ https://dbrgn.github.io/tealdeer/
wget -O ~/temp/tealdeer-linux-x86_64-musl https://github.com/dbrgn/tealdeer/releases/download/v1.5.0/tealdeer-linux-x86_64-musl
chmod +x ~/temp/tealdeer-linux-x86_64-musl
mv ~/temp/tealdeer-linux-x86_64-musl ~/.local/bin/tealdeer
~/.local/bin/tealdeer --update

# Zoxide (smart cd) @ https://github.com/ajeetdsouza/zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

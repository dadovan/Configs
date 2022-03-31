#!/bin/sh

###################################################################################################
# Manual Steps:
# curl https://raw.githubusercontent.com/dadovan/Configs/master/Arch/setup.sh > ~/setup.sh
# chmod +x ~/setup.sh
# ./setup.sh
# rm ~/setup.sh
#
# You should also install a more complete font
# https://www.nerdfonts.com/font-downloads (currently using Caskaydia Cove Mono NF)

###################################################################################################
# Base

sudo apt update
sudo apt upgrade

## Configs

mkdir ~/.config
mkdir ~/git
cd ~/git
git clone https://github.com/dadovan/Configs.git
cp -r ~/git/Configs/.config/tmux ~/.config/
cp -r ~/git/Configs/.config/vim ~/.config/

echo "source ~/.config/zsh/.zshrc" > ~/.zshrc

## Zsh

sudo apt install zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.config/zsh/zsh-completions
cp -r ~/git/Configs/.config/zsh ~/.config/
chsh -s /bin/zsh

###################################################################################################
# Apps

sudo apt install bat                        # cat replacement @ https://github.com/sharkdp/bat
sudo apt install fzf                        # Command-line fuzzy finder @ https://github.com/junegunn/fzf
sudo apt install mc                         # Midnight Commander
sudo apt install ncdu                       # NCurses Disk Usage @ https://dev.yorhel.nl/ncdu
sudo apt install neofetch
sudo apt install stacer                     # Sytem monitoring and config @ https://oguzhaninan.github.io/Stacer-Web/

# TODO: Ensure these release versions are up-to-date
curl -L https://github.com/zyedidia/micro/releases/download/v2.0.10/micro-2.0.10-amd64.deb -o micro-2.0.10-amd64.deb
sudo apt install ./micro-2.0.10-amd64.deb

curl -L https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip -o exa-linux-x86_64-v0.10.1.zip
sudo unzip -j /mnt/c/Users/dadov/Downloads/exa-linux-x86_64-v0.10.1.zip bin/exa -d /usr/local/bin

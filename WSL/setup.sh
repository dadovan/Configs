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
cd ~

echo "source ~/.config/zsh/.zshrc" > ~/.zshrc
echo "source-file ~/.config/tmux/.tmux.conf" > ~/.tmux.conf

## Zsh

sudo apt install zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.config/zsh/zsh-completions
cp -r ~/git/Configs/.config/zsh ~/.config/
chsh -s /bin/zsh

# Starship prompt
curl -sS https://starship.rs/install.sh | sh

###################################################################################################
# Apps

sudo apt install bat                        # cat replacement @ https://github.com/sharkdp/bat
sudo apt install btop                       # Top replacement @ https://github.com/aristocratos/btop
sudo apt install exa                        # ls replacement @ https://the.exa.website/
sudo apt install fzf                        # Command-line fuzzy finder @ https://github.com/junegunn/fzf
# sudo apt install mc                       # Midnight Commander
sudo apt install micro                      # Micro editor @ https://micro-editor.github.io/
sudo apt install ncdu                       # NCurses Disk Usage @ https://dev.yorhel.nl/ncdu
sudo apt install neofetch
sudo apt install ranger                     # Ranger file manager @ https://ranger.github.io/
# sudo apt install stacer                   # Sytem monitoring and config @ https://oguzhaninan.github.io/Stacer-Web/

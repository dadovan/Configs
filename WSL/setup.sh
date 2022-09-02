#!/bin/sh

###################################################################################################
# Manual Steps:
# curl https://raw.githubusercontent.com/dadovan/Configs/master/WSL/setup.sh > ~/setup.sh
# chmod +x ~/setup.sh
# ./setup.sh
# rm ~/setup.sh
#
###################################################################################################

# Base

sudo apt update
sudo apt upgrade

mkdir ~/.config
mkdir ~/git
mkdir -p ~/temp
git clone https://github.com/dadovan/Configs.git ~/git/Configs

# Zsh

echo "source ~/.config/zsh/.zshrc" > ~/.zshrc
sudo apt install zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.config/zsh/zsh-completions
cp -r ~/git/Configs/.config/zsh ~/.config/
chsh -s /bin/zsh

echo "ZDOTDIR=$HOME/.config/zsh\
. $ZDOTDIR/.zshenv" > ~/.zshenv

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Starship prompt
brew install starship
cp ~/git/Configs/.config/starship.toml ~/.config

# Install Cascadia Cove Nerd Font
brew install fontconfig
brew install zip unzip
wget -O ~/temp/CascadiaCode https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip
mkdir -p ~/.fonts
unzip ~/temp/CascadiaCode.zip -d ~/.fonts
fc-cache -fv

###################################################################################################
# Apps

brew install bat                        # bat (improved cat) @ https://github.com/sharkdp/bat
brew install btop                       # btop op replacement @ https://github.com/aristocratos/btop
brew install exa                        # ls replacement @ https://the.exa.website/
brew install fzf                        # Command-line fuzzy finder @ https://github.com/junegunn/fzf
brew install git-delta                  # Git Delta @ https://github.com/dandavison/delta
brew install gitui                      # Git UI @ https://github.com/extrawurst/gitui
# brew install lazydocker				# Simple docker UI
brew install lnav                       # Logfile Navigator @ https://lnav.org/
brew install mc                         # Midnight Commander
brew install micro                      # Micro editor @ https://micro-editor.github.io/
brew install ncdu                       # NCurses Disk Usage @ https://dev.yorhel.nl/ncdu
brew install p7zip						# 7zip
# sudo apt install ranger               # Ranger file manager @ https://ranger.github.io/
brew install ripgrep                    # Better grep @ https://github.com/BurntSushi/ripgrep
# sudo apt install stacer               # Sytem monitoring and config @ https://oguzhaninan.github.io/Stacer-Web/
brew install tealdeer                   # tldr client @ https://dbrgn.github.io/tealdeer/
brew install zoxide                     # Zoxide (smart cd) @ https://github.com/ajeetdsouza/zoxide

# Tmux (preinstalled)
cp -r ~/git/Configs/.config/tmux ~/.config/
echo "source-file ~/.config/tmux/.tmux.conf" > ~/.tmux.conf

# VIM (preinstalled)
cp -r ~/git/Configs/.config/vim ~/.config/

###################################################################################################
# Apps not in apt or too old in apt (Ubuntu 20.04 is the default, Ubuntu 22.04 hangs frequently)
# Double-check for latest versions

# Install Kitty and pre-reqs
# https://github.com/danielbisar/settings/blob/main/guides/kitty-on-windows-with-wsl2.md
mkdir -p ~/.config/kitty
cp -r ~/git/Configs/.config/kitty ~/.config/
sed 's/super/alt/' ~/.config/kitty/kitty.conf > ~/.config/kitty/kitty.conf.wsl

sudo apt install x11-apps
sudo apt install mesa-utils
sudo apt install libwayland-egl1-mesa
mv ~/.config/kitty/kitty.conf.wsl ~/.config/kitty/kitty.conf
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin

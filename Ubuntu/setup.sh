#!/bin/sh

# Update repositories
# sudo add-apt-repository ppa:gnome-terminator
apt-get update

# Adds
apt-get install curl
apt-get install evince # PDF reader
apt-get install htop
apt-get install git
apt-get install gnome-tweaks
apt-get install ncdu
apt-get install net-tools
apt-get install terminator
apt-get install tree

# Install Visual Studio Code
# https://code.visualstudio.com/docs/setup/linux
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get install apt-transport-https
apt-get update
apt-get install code

# Maybe adds
#apt-get install glances
#apt-get install krusader
#apt-get install mc
#apt-get install zsh oh_my_zsh

# Removes. At the end so we don't remove dependency only to add it right back.
apt-get remove thunderbird

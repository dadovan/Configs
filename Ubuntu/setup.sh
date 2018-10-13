#!/bin/sh

# Update repositories
# sudo add-apt-repository ppa:gnome-terminator
apt-get update

# Adds
apt-get install curl
apt-get install evince # PDF reader
apt-get install htop
apt-get install git
apt-get install terminator
apt-get install glances
# ???
apt-get install krusader
apt-get install mc
apt-get install zsh oh_my_zsh

# Removes. At the end so we don't remove dependency only to add it right back.
apt-get remove thunderbird

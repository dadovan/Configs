#!/bin/sh

###################################################################################################
# TODO: Move git Configs to the start so the setup script can handle ssh setup

###################################################################################################
# Manual Steps:
# curl https://raw.githubusercontent.com/dadovan/Configs/master/Arch/setup.sh > ~/setup.sh
# chmod +x ~/setup.sh
# ./setup.sh
# rm ~/setup.sh

###################################################################################################
# Base

sudo pacman -Syu vim git

## Configs

mkdir ~/.config
mkdir ~/git
cd ~/git
git clone https://github.com/dadovan/Configs.git
cp -r ~/git/Configs/.config/tmux ~/.config/
cp -r ~/git/Configs/.config/vim ~/.config/
cp -r ~/git/Configs/.config/zsh ~/.config/

echo "source ~/.config/zsh/.zshrc" > ~/.zshrc
echo ":source ~/.config/vim/.vimrc" > ~/.vimrc

## nftables/SSH
sudo pacman -Syu nftables openssh

sudo sed -i 's/tcp dport ssh accept/tcp dport 4316 accept/' /etc/nftables.conf
sudo systemctl enable nftables.service
sudo systemctl start nftables.service

sudo sed -i 's/#Port 22/Port 4316/' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

mkdir ~/.ssh
chmod 700 ~/.ssh

# TODO: SSHGuard + key-based ssh?  https://austingwalters.com/configure-ssh-on-an-arch-linux-server/

## Zsh

sudo pacman -Syu zsh
chsh -s /bin/zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.config/zsh/zsh-completions

#export GEM_HOME="$HOME/.gem"
# sudo pacman -Syu ruby
# gem install colorls

## yay

sudo pacman -Syu base-devel
git clone https://aur.archlinux.org/yay.git ~/git/yay
cd ~/git/yay
makepkg -si

###################################################################################################
# Desktop environment

## Fonts

yay -S nerd-fonts-fira-code

## Environment

sudo pacman -Syu xorg xorg-apps xorg-xinit
sudo pacman -Syu awesome rofi
sudo pacman -Syu picom  # Compositor
sudo pacman -Syu pulseaudio

# https://github.com/dylanaraps/neofetch/blob/master/neofetch, get_model()
if [[ -f /sys/devices/virtual/dmi/id/product_name || -f /sys/devices/virtual/dmi/id/product_version ]]; then
    model=$(< /sys/devices/virtual/dmi/id/product_name)
    model+=" $(< /sys/devices/virtual/dmi/id/product_version)"
    # https://stackoverflow.com/a/8811800/346808
    if test "${model#*Hyper}" != "$model"; then
        sudo pacman -Syu xf86-video-fbdev  # For Hyper-V
    fi
fi

head -n -5 /etc/X11/xinit/xinitrc > ~/.xinitrc
echo "nitrogen --restore &" >> ~/.xinitrc
echo "picom &" >> ~/.xinitrc
echo "exec awesome" >> ~/.xinitrc

## xrdp

sudo pacman -S xrdp


###################################################################################################
# Apps

## Additional terminal packages

sudo pacman -Syu dhex
sudo pacman -Syu man-db less man-pages  # https://wiki.archlinux.org/index.php/Man_page
sudo pacman -Syu tmux
sudo pacman -Syu fzf
sudo pacman -Syu htop mc ncdu neofetch
sudo pacman -Syu weechat

## X packages

sudo pacman -Syu nitrogen
sudo pacman -Syu thunar
sudo pacman -Syu vlc
yay -S microsoft-edge-dev-bin
yay -S visual-studio-code-bin

yay -S stacer-bin
yay -S st

###################################################################################################
# To investigate

# clipman  clipboard manager
# trayer  # system tray
# dunst   notification system
# file manager: pcmanfm?
# gimp, inkscape
# App outlet (Ap?

# gem install mdless  # https://github.com/ttscoff/mdless


### Working:
sudo pacman -Syu x2goserver
sudo x2godbadmin --createdb
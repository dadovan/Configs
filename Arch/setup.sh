#!/bin/sh

# TODO: Move git Configs to the start so the setup script can handle ssh setup

## Arch:

### Base
sudo pacman -Sy vim tmux git

### nftables/SSH
sudo pacman -Sy nftables openssh

sudo sed -i 's/tcp dport ssh accept/tcp dport 4316 accept/' /etc/nftables.conf
sudo systemctl enable nftables.service
sudo systemctl start nftables.service

sudo sed -i 's/#Port 22/Port 4316/' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogon no/' /etc/ssh/sshd_config
sudo sed -i 's/#X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

mkdir ~/.ssh
chmod 700 ~/.ssh

# TODO: SSHGuard + key-based ssh?  https://austingwalters.com/configure-ssh-on-an-arch-linux-server/


### Configs

mkdir ~/.config
mkdir ~/git
cd ~/git
git clone https://github.com/dadovan/Configs.git
cp -r ~/git/Configs/.config/tmux ~/.config/tmux
cp -r ~/git/Configs/.config/vim ~/.config/vim
cp -r ~/git/Configs/.config/zsh ~/.config/zsh

echo "source ~/.config/zsh/.zshrc" > ~/.zshrc
echo ":source ~/.config/vim/.vimrc" > ~/.vimrc

### Zsh

sudo pacman -Sy zsh
chsh -s /bin/zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.config/zsh/zsh-completions

export GEM_HOME="$HOME/.gem"
sudo pacman -Sy base-devel
sudo pacman -Sy ruby
gem install colorls

### yay

git clone https://aur.archlinux.org/yay.git ~/git/yay
cd ~/git/yay
makepkg -si

### Fonts

yay -S nerd-fonts-fira-code

### Desktop environment
sudo pacman -Sy awesome rofi

### Additional packages
sudo pacman -Sy man-db less man-pages  # https://wiki.archlinux.org/index.php/Man_page
sudo pacman -Sy fzf
sudo pacman -Sy htop mc ncdu
sudo pacman -Sy weechat

gem install mdless  # https://github.com/ttscoff/mdless

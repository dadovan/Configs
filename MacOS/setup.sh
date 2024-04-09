# General setup

# Karabiner Elements implements simple keyboard remapping on a global and a per-app basis.
# Hammerspoon implements custom macOS automation features (like cheatsheets and window movement)

# Install apps

brew install --cask alt-tab             # MacOS alt-tab replacement @ https://alt-tab-macos.netlify.app/
pip install asitop                      # Performance monitor CLI for Apple Silicon @ https://www.github.com/tlkh/asitop
brew install awscli                     # AWS CLI @ https://aws.amazon.com/cli/
brew install bat                        # bat (improved cat) @ https://github.com/sharkdp/bat
brew install btop                       # btop op replacement @ https://github.com/aristocratos/btop
brew install exa                        # ls replacement @ https://the.exa.website/
brew install fd                         # find replacement @ https://github.com/sharkdp/fd
pip install frogmouth                   # Markdown Browser @ https://github.com/Textualize/frogmouth
brew install fzf                        # Command-line fuzzy finder @ https://github.com/junegunn/fzf
brew install git-delta                  # Git Delta @ https://github.com/dandavison/delta
brew install gitui                      # Git UI @ https://github.com/extrawurst/gitui
brew install glow                       # Markdown renderer @ https://github.com/charmbracelet/glow
brew install hammerspooon               # MacOS Automation @ http://www.hammerspoon.org/
brew install jq                         # https://jqlang.github.io/jq/
brew install kitty                      # Terminal emulator @ https://sw.kovidgoyal.net/kitty/
brew install lazydocker                 # Simple docker UI @ https://github.com/jesseduffield/lazydocker
brew install lnav                       # Logfile Navigator @ https://lnav.org/
brew install mc                         # Midnight Commander @ http://midnight-commander.org/
brew install micro                      # Micro editor @ https://micro-editor.github.io/
brew install mpv                        # https://mpv.io
brew install navi                       # https://github.com/denisidoro/navi
brew install ncdu                       # NCurses Disk Usage @ https://dev.yorhel.nl/ncdu
brew install p7zip                      # 7zip @ https://www.7-zip.org/
brew install ripgrep                    # Better grep @ https://github.com/BurntSushi/ripgrep
brew install starship                   # Terminal prompt @ https://starship.rs/
brew install tealdeer                   # tldr client @ https://dbrgn.github.io/tealdeer/
brew install tmux                       # Terminal multiplexer @ https://github.com/tmux/tmux/wiki
brew install saulpw/vd/visidata         # Data exploration @ https://www.visidata.org/
brew install wtfutil                    # Terminal Dashboad @ https://wtfutil.com/
brew install xplr                       # Terminal file explorer @ https://xplr.dev/
brew install yazi                       # Terminal file manager @ https://github.com/sxyazi/yazi
brew install zoxide                     # Zoxide (smart cd) @ https://github.com/ajeetdsouza/zoxide


# https://www.brow.sh/
brew tap browsh-org/homebrew-browsh
brew install firefox
brew install browsh

# Manual installs:
# Bartender

# Flow

# Karabigner-Elements

# iStats

# JetBrains Toolbox

# OneDrive

# Raycast @ https://www.raycast.com/

# TinkerTool @ https://www.bresink.com/osx/0TinkerTool/download.php
#    Applications -> Mission Control -> No delay
#    Dock -> Use dimmed icons
#    Dock -> Disable animation
#    Dock -> Disable delay


echo "ZDOTDIR=$HOME/.config/zsh\
. $ZDOTDIR/.zshenv" > ~/.zshenv

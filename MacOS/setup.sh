brew install --cask alt-tab				# MacOS alt-tab replacement @ https://alt-tab-macos.netlify.app/
brew install bat                        # bat (improved cat) @ https://github.com/sharkdp/bat
brew install btop                       # btop op replacement @ https://github.com/aristocratos/btop
brew install exa                        # ls replacement @ https://the.exa.website/
brew install fzf                        # Command-line fuzzy finder @ https://github.com/junegunn/fzf
brew install git-delta                  # Git Delta @ https://github.com/dandavison/delta
brew install gitui                      # Git UI @ https://github.com/extrawurst/gitui
brew install glow						# Markdown renderer @ https://github.com/charmbracelet/glow
brew install hammerspooon				# MacOS Automation @ http://www.hammerspoon.org/
brew install kitty						# Terminal emulator @ https://sw.kovidgoyal.net/kitty/
brew install lazydocker					# Simple docker UI @ https://github.com/jesseduffield/lazydocker
brew install lnav                       # Logfile Navigator @ https://lnav.org/
brew install mc                         # Midnight Commander @ http://midnight-commander.org/
brew install micro                      # Micro editor @ https://micro-editor.github.io/
brew install ncdu                       # NCurses Disk Usage @ https://dev.yorhel.nl/ncdu
brew install p7zip						# 7zip @ https://www.7-zip.org/
brew install ripgrep                    # Better grep @ https://github.com/BurntSushi/ripgrep
brew install starship					# Terminal prompt @ https://starship.rs/
brew install tealdeer                   # tldr client @ https://dbrgn.github.io/tealdeer/
brew install tmux						# Terminal multiplexer @ https://github.com/tmux/tmux/wiki
brew install wtfutil					# Terminal Dashboad @ https://wtfutil.com/
brew install xplr						# Terminal file explorer @ https://xplr.dev/
brew install zoxide                     # Zoxide (smart cd) @ https://github.com/ajeetdsouza/zoxide

# https://www.brow.sh/
brew tap browsh-org/homebrew-browsh
brew install firefox
brew install browsh

echo "ZDOTDIR=$HOME/.config/zsh\
. $ZDOTDIR/.zshenv" > ~/.zshenv

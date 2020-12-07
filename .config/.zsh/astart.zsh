## Configure options

# Changing directories

setopt AUTO_CD                    # Go to folder path without using cd.
setopt AUTO_PUSHD                 # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS          # Do not store duplicates in the stack.
setopt PUSHD_SILENT               # Do not print the directory stack after pushd or popd.

# Expansion and globbing

unsetopt CASE_GLOB                # Make globbing (filename generation) sensitive to case.
setopt NOMATCH                    # Print error if filename expansion has no matches.

# History

setopt APPEND_HISTORY             # Append rather than overwrite history file.
setopt AUTO_LIST                  # Automatically list choices on an ambiguous completion.
setopt EXTENDED_HISTORY           # Write the history file in the ':start:elapsed;command' format.
setopt HIST_IGNORE_ALL_DUPS       # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS           # Do not record an event that was just recorded again.
setopt HIST_VERIFY                # Do not execute immediately upon history expansion.

autoload -Uz compinit; compinit   # Initialize completion

## Exports

export HISTFILE="$HOME/.zhistory"

export HISTSIZE=10000   # Max events for internal history
export SAVEHIST=10000   # Max events in history file

export GEM_HOME="$HOME/.gem"

## Aliases

# This alias shows a list of past dirs and allows you to enter the # of the dir to jump to
# http://zsh.sourceforge.net/Intro/intro_6.html
DIRSTACKSIZE=20
alias d='dirs -v'
for index ({1..19}) alias "$index"="cd +${index}"; unset index

alias grep="grep --color=auto"
alias ls="colorls -lA --sd"
alias mc="mc -x"  # Enable mouse support under tmux - https://github.com/Bash-it/bash-it/issues/771
alias ping="ping -c 5"
alias tmux="tmux -f ~/.config/.tmux/.tmux.conf"
alias untar="tar -zxvf"

## Functions

# Associative arrays: https://scriptingosx.com/2019/11/associative-arrays-in-zsh/
backup() {
    local noColor="\033[0m"
    local green="\033[1;32m"
    local backupFile=~/.oh-my-zsh/custom/.backupSettings

    if [ -s $backupFile ]
    then
        source $backupFile
        echo "${green}Last backup was on $backupSettings[lastRebuild] ${noColor}"
    else
        echo "${green}No previous backups found${noColor}"
        declare -A backupSettings
        backupSettings[lastRebuild]=$(date +%F)
    fi

    local lastRebuildDate=$(date -d $backupSettings[lastRebuild] +%s)
    local newRebuildDate=$(date +%s --date='7 days ago')
    if [ $newRebuildDate -ge $lastRebuildDate ]
    then
        echo "${green}Rebuilding full backup"
        rm /mnt/c/Users/dadov/Documents/Backup-$WSL_DISTRO_NAME.zip
    fi

    echo "${green}Archiving home folder...${noColor}"
    zip -qr9 /mnt/c/Users/dadov/Documents/Backup-$WSL_DISTRO_NAME.zip ~
    cp ~/.vimrc /mnt/c/Users/dadov/Documents/dadovan.github.io/Data/Linux/Configs
    cp ~/.zshenv /mnt/c/Users/dadov/Documents/dadovan.github.io/Data/Linux/Configs
    cp ~/.zshrc /mnt/c/Users/dadov/Documents/dadovan.github.io/Data/Linux/Configs
    cp ~/.oh-my-zsh/custom/* /mnt/c/Users/dadov/Documents/dadovan.github.io/Data/Linux/Configs/.oh-my-zsh/custom

    backupSettings[lastRebuild]=$(date +%F)
    echo "declare -A backupSettings" > $backupFile
    for key value in ${(kv)backupSettings}
    do
        echo "backupSettings[$key]=$value" >> $backupFile
    done
    backupSettings=( )
}

## Key bindings

# https://unix.stackexchange.com/a/117162
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.htmlcd 
#bindkey '^[[A' history-substring-search-up      # Up arrow
#bindkey '^[[B' history-substring-search-down    # Down arrow
bindkey '\e' kill-whole-line                    # ESC (note a pause as zsh listens for a second keystroke)
bindkey '^[[1;5H' beginning-of-line             # Ctrl-Home
bindkey '^[[1;5F' end-of-line                   # Ctrl-End
bindkey '^[[1;5C' forward-word                  # Ctrl-Right
bindkey '^[[1;5D' backward-word                 # Ctrl-Left
# Interesting: https://stackoverflow.com/questions/5407916/zsh-zle-shift-selection

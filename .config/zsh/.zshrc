# With help from:
# https://thevaluable.dev/zsh-install-configure/

cd $HOME

##################################################################################################
## Configure options

DISABLE_AUTO_TITLE="true"                   # Disable auto-setting terminal title.
HIST_STAMPS="%F %T"                         # History command output is YYYY-MM-DD HH-MM-SS (24h) (see 'man strftime' for details)

# Changing directories

setopt AUTO_CD                      # Go to folder path without using cd.
setopt AUTO_PUSHD                   # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS            # Do not store duplicates in the stack.
setopt PUSHD_SILENT                 # Do not print the directory stack after pushd or popd.

# Expansion and globbing

unsetopt CASE_GLOB                  # Make globbing (filename generation) sensitive to case.
setopt NOMATCH                      # Print error if filename expansion has no matches.

# History

setopt APPEND_HISTORY               # Append rather than overwrite history file.
setopt AUTO_LIST                    # Automatically list choices on an ambiguous completion.
setopt EXTENDED_HISTORY             # Write the history file in the ':start:elapsed;command' format.
setopt HIST_IGNORE_ALL_DUPS         # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS             # Do not record an event that was just recorded again.
setopt HIST_VERIFY                  # Do not execute immediately upon history expansion.

zstyle ':completion:*' menu select  # Enables tab selection of multiple-choice items

##################################################################################################
## Exports

export HISTFILE="$HOME/.zhistory"

export HISTSIZE=10000   # Max events for internal history
export SAVEHIST=10000   # Max events in history file

export GEM_HOME="$HOME/.gem"
export PATH=$PATH:~/.gem/ruby/2.7.0/bin

[[ -n $SSH_CLIENT ]] && export DISPLAY=$(echo $SSH_CLIENT | awk '{print $1}'):0

##################################################################################################
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
alias tmux="tmux -f ~/.config/tmux/.tmux.conf"
alias untar="tar -zxvf"

##################################################################################################
## Functions

##################################################################################################
## Key bindings

# https://unix.stackexchange.com/a/117162
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.htmlcd
#bindkey '^[[A' history-substring-search-up      # Up arrow
#bindkey '^[[B' history-substring-search-down    # Down arrow
bindkey '\e' kill-whole-line                    # ESC (note a pause as zsh listens for a second keystroke)
bindkey '^[[1~' beginning-of-line               # Home
bindkey '^[[1;5H' beginning-of-line             # Ctrl-Home
bindkey '^[[4~' end-of-line                     # End
bindkey '^[[1;5F' end-of-line                   # Ctrl-End
bindkey '^[[1;5C' forward-word                  # Ctrl-Right
bindkey '^[[1;5D' backward-word                 # Ctrl-Left
bindkey '^[[13' delete-char                     # Delete
# Interesting: https://stackoverflow.com/questions/5407916/zsh-zle-shift-selection

##################################################################################################
## Misc

##################################################################################################
## Additional loads

autoload -Uz ~/.config/zsh/prompt; prompt

# https://github.com/zsh-users/zsh-completions
fpath=($HOME/.config/zsh/zsh-completions/src $fpath)
autoload -Uz compinit; compinit     # Initialize completions

# https://github.com/zsh-users/zsh-autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Must be the last plugin souced
# https://github.com/zsh-users/zsh-syntax-highlighting
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

percentage=66

WIDTH=$(expr $(tmux display -p '#{window_width}') \* $percentage \/ 100)
HEIGHT=$(expr $(tmux display -p '#{window_height}'))

tmux swap-pane -t 0
tmux select-pane -t 0
tmux select-layout main-vertical
tmux resize-pane -t 0 -x $WIDTH -y $HEIGHT

exit 0

#!/bin/bash

# Get all tmuxp sessions
tmuxp_sessions=$(tmuxp ls | awk '{print $1}')

# If tmux is running on current or other terminal
tmux_running=$(tmux ls 2> /dev/null)

# Get all tmux running sessions that are not already present in tmuxp
if [ -n "$tmux_running" ]; then
    tmux_filtered_sessions=$(tmux ls | awk '{$2; {print substr($1, 1, length($1)-1)}}' | grep -vxF "$tmuxp_sessions")
else
    tmux_filtered_sessions=""
fi

# Show all candidates using fzf
selected_session=$(echo -n -e "$tmuxp_sessions\n$tmux_filtered_sessions" | fzf --border none --prompt="select session> ")

# Attach to the selected session of tmuxp or tmux
# If inside tmux then switch to selected session
if [[ -n $selected_session ]]; then
    if [[ $tmuxp_sessions =~ $selected_session ]]; then
        tmuxp load -y $selected_session
    else
	if [ -n "$TMUX" ]; then
		tmux switch-client -t $selected_session
	else
		tmux a -t $selected_session
	fi
    fi
fi

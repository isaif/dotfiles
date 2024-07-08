# This is a bash script which can create sessions and switch sessions
# session can be from tmuxp session yml file
# or a directory from anywhere in home directory
# it requires fzf for fuzzy completion
# it also requires fd for fast directory searching
# it has support for tmuxp
# future goal is to make fd and tmuxp optional
# Note: this script creates session name using basename of location
# tmuxp saved yaml file name should match 'session_name' inside the file
# otherwise there will be two entry pointing to same session
#!/bin/bash

# echo " " >> /tmp/omnilog
# echo "____________start of script ___________" >> /tmp/omnilog
# Get all tmuxp sessions
tmuxp_saved_sessions=$(tmuxp ls | awk '{print $1}')

# Check if tmux is running on current or other terminal
tmux_running=$(tmux ls 2> /dev/null)

# proje=$(fd . ~ --type d --hidden --follow --exclude .git --exclude .cache| fzf --border none)
proje=$(fd . ~ --type d --hidden --follow --exclude .git --exclude .cache)

# Get all tmux running sessions that are not already present in tmuxp
if [ -n "$tmux_running" ]; then
    tmux_filtered_sessions=$(tmux ls | awk '{$2; {print substr($1, 1, length($1)-1)}}' | grep -vxF "$tmuxp_saved_sessions")
    tmuxp_running_session=$(tmux ls | awk '{$2; {print substr($1, 1, length($1)-1)}}' | grep -xF "$tmuxp_saved_sessions")
else
    tmux_filtered_sessions=""
    tmuxp_running_session=""
fi

if [[ $# -eq 1 ]]; then
    selected=$1
else
    # selected=$(find ~/work/builds ~/projects ~/ ~/work ~/personal ~/personal/yt -mindepth 1 -maxdepth 1 -type d | fzf)

    # Show all candidates using fzf
    # selected_session=$(echo -n -e "$tmuxp_saved_sessions\n$tmux_filtered_sessions\n$proje" | fzf --border none --prompt="select session> ")
    selected=$(echo -n -e "$tmuxp_saved_sessions\n$tmux_filtered_sessions\n$proje" | fzf --height 100% --border none --prompt="select session> ")
    # selected=$(echo -n -e "$proje" | fzf --border none --prompt="select session> ")

fi

if [[ -z $selected ]]; then
    exit 0
#     echo "nothing selected" >> /tmp/omnilog
fi

selected_name=$(basename "$selected" | tr . _)
#
# # Attach to the selected session of tmuxp or tmux
# # If inside tmux then switch to selected session
# if [[ -n $selected_session ]]; then
#     if [[ $tmuxp_saved_sessions =~ $selected_session ]]; then
#         tmuxp load -y $selected_session
#     else
# 	if [ -n "$TMUX" ]; then
# 		tmux switch-client -t $selected_session
# 	else
# 		tmux a -t $selected_session
# 	fi
#     fi
# fi

# echo "selected $selected" >> /tmp/omnilog
# echo "selected_name $selected_name" >> /tmp/omnilog

# echo " " >> /tmp/omnilog
# echo "tmuxp running sessions :" >> /tmp/omnilog
# echo "$tmuxp_running_session" >> /tmp/omnilog
# echo " " >> /tmp/omnilog

# echo " " >> /tmp/omnilog
# echo "tmuxp saved sessions :" >> /tmp/omnilog
# echo "$tmuxp_saved_sessions" >> /tmp/omnilog
# echo " " >> /tmp/omnilog

# echo " " >> /tmp/omnilog
# echo "tmux only sessions :" >> /tmp/omnilog
# echo "$tmux_filtered_sessions" >> /tmp/omnilog
# echo " " >> /tmp/omnilog

# Use tmuxp load if that session i.e selected_name in not running
# and it has tmuxp saved file
first=false
second=false

if [[ ! $tmuxp_running_session =~ $selected_name ]]; then
#   echo "tmuxp session $selected_name is running" >> /tmp/omnilog
  first=true
# else
#   echo "tmuxp session $selected_name is not running" >> /tmp/omnilog
fi

if [[ $tmuxp_saved_sessions =~ $selected_name ]]; then
#   echo "$selected_name belongs to saved tmuxp sessions" >> /tmp/omnilog
  second=true
fi

# echo "first $first     second $second " >> /tmp/omnilog

# if [[ $first = true]] && [[ $second = true]]; then
if [[ $first = true &&  $second = true ]]; then
#   echo "both are true" >> /tmp/omnilog
#   echo "loading a tmuxp session for $selected_name" >> /tmp/omnilog
    tmuxp load -y $selected_name
    exit 0
fi

# if [[ ! $tmuxp_running_sessions =~ $selected_name ]] && [[ $tmuxp_saved_sessions =~ $selected_name]]; then
#     tmuxp load -y $selected_name
#     exit 0
# fi

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
#     echo "tmux is not running and not inside tmux. so create session" >> /tmp/omnilog
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
#     echo "$selected_name session is not running in tmux" >> /tmp/omnilog
#     echo "so create detached session" >> /tmp/omnilog
    tmux new-session -ds $selected_name -c $selected
fi

# echo "switching client to $selected_name" >> /tmp/omnilog
tmux switch-client -t $selected_name

#!/usr/bin/env bash

file_path=""
session_name=""
session_path=""

is_tmux_active=$TMUX

get_session_name_and_path() {
    local val="$1"
    item_count=$(echo $val | wc -w)
    echo "item_count is $item_count" >> /tmp/zaplog

    if [ $item_count -eq 1 ]; then
        # start a new session with given path
        session_path=$(echo "$val" | awk '{print $1}')
        session_name=$(basename "$session_path")
        session_path=$(eval echo "$session_path")

        tmux new-session -ds "$session_name" -c "$session_path"
        tmux switch-client -t "$session_name"
        echo "starting session $session_name with path $session_path" >> /tmp/zaplog

    elif [ $item_count -eq 2 ]; then
        # switch session
        session_name=$(echo "$val" | awk '{print $1}')
        session_path=$(echo "$val" | awk '{print $2}')
        tmux switch-client -t "$session_name"
        echo "switching to existing session $session_name" >> /tmp/zaplog

    elif [ $item_count -eq 3 ]; then
        # start smug project
        file_path=$(echo "$val" | awk '{print $1}' | sed 's/.yml//' )
        file_name=$(basename "$file_path")
        session_name=$(echo "$val" | awk '{print $2}')
        session_path=$(echo "$val" | awk '{print $3}')
        smug start "$file_name"
        tmux switch-client -t "$session_name"
        echo "starting smug project" >> /tmp/zaplog
    fi

    echo "file_path is $file_path" >> /tmp/zaplog
    echo "session_name is $session_name" >> /tmp/zaplog
    echo "session_path is $session_path" >> /tmp/zaplog
}

# Main function
main() {
    echo "-------------------------" >> /tmp/zaplog
    echo "    " >> /tmp/zaplog
    echo "    " >> /tmp/zaplog
    echo "    " >> /tmp/zaplog

    local dirs=$(fd . ~/projects ~/experiments ~/nix-config --type d --hidden --follow --exclude .git --exclude .cache)

    local selected

    local rg_output=$(rg '^root:|^session:' --no-line-number -m 2 ~/.config/smug | sed -n 'N;s/\(.*\):session: \(.*\)\n\1:root: \(.*\)/\1\t\2\t\3/p')

    local tmux_running_sessions=$(tmux list-sessions -F "#{session_name}: #{session_path}"  | sed 's/:/\t/')

    # Combine directories, sessions, and smug output
    combined_output=$(echo -ne "$tmux_running_sessions\n$rg_output\n$dirs" | sed "s|$HOME|~|" | awk '!a[$NF]++')

    if [[ -n "$is_tmux_active" ]]; then
        # selected=$(tmux display-popup -E "echo -ne \"$combined_output\" | fzf")

        temp_file=$(mktemp)
        tmux display-popup -E "echo -ne \"$combined_output\" | fzf > $temp_file"
        selected=$(cat "$temp_file")
        rm "$temp_file"

    else
        selected=$(echo -ne "$combined_output" | fzf)
    fi

    echo "selected is $selected" >> /tmp/zaplog

    if [[ -z $selected ]]; then
        exit 0
    fi

    get_session_name_and_path "$selected"
}

main

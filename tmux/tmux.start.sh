#!/bin/sh
export PATH=$PATH:/usr/local/bin

# abort if we're already inside a TMUX session
[ "$TMUX" == "" ] || exit 0

# startup a "base" session if none currently exists
tmux has-session -t base || tmux new-session -s base -d

PS3="Choose your session: "
options=($(tmux list-sessions -F "#S") "NEW SESSION" "ZSH")
echo "Available sessions"
echo "------------------"
echo " "
select opt in "${options[@]}"
do
    case $opt in
        "NEW SESSION")
            read -p "Enter new session name: " SESSION_NAME
            tmux new -s "$SESSION_NAME"
            break
            ;;
        "ZSH")
            zsh --login
            break;;
        *)
            tmux attach-session -t $opt
            break
            ;;
    esac
done

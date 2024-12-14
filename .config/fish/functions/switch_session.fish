function switch_session
    # Check if tmux is running
    if not tmux list-sessions > /dev/null 2>&1
        echo "No tmux sessions found."
        return 1
    end

    # Use fzf to select a session
   set session (tmux list-sessions -F "#S" | fzf --layout=reverse-list --query="$argv" --padding="1,0" --layout="reverse" --height="20" --no-separator --tmux="center")

    # If a session is selected, switch to it
    if test -n "$session"
        tmux switch-client -t "$session"
    end
end

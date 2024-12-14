function create_tmux_window

    set WINDOW_NAME $argv[1]
    set COMMAND $argv[2]
    set SESSION_NAME $argv[3]
    
    if test -z "$WINDOW_NAME"
        echo "Usage: create_tmux_window <window_name> [session_name]"
        return 1
    end
    
    # Default to the current session if no session name is provided
    if test -z "$SESSION_NAME"
        set SESSION_NAME (tmux display-message -p '#S')
    end

    if not tmux list-windows -t $SESSION_NAME | grep -q "^.*: $WINDOW_NAME"
        if $COMMAND 
            tmux new-window -n $WINDOW_NAME $COMMAND Cm
        else
            tmux new-window -n $WINDOW_NAME
        end
        # If the window doesn't exist, create it
    end

end

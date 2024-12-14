function tmux_dev
    #tmux new-window -n Code "nvim" Cm
    #tmux new-window -n Server
    # Rename the first window to "Cli"


    tmux new-window -t 1 -n "Cli" 

    # Open the second window named "Code" and run "nvim"
    tmux new-window -n "Code" -t 2 -d "nvim ."

    # Open the third window named "Server"
    tmux new-window -n "Server" -t 3 -d
    #tmux rename-window -t 1 Cli


end

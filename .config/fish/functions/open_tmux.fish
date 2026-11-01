function open_tmux
    if not in_tmux
        tmux new-session -As0 tmux_dev
    else
        tmux_dev
    end
end

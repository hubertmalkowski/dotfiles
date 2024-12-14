function open_tmux
    if not in_tmux
        tmux new -As0 tmux_dev
    else
        tmux_dev
    end
end

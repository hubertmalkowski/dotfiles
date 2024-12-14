function in_tmux
    if test "$TERM" = "screen" -o "$TERM" = "screen-256color"
        if set -q TMUX
            return 0
        end
    end
    return 1
end


function notes

    set -l sessname "notes"

    if in_tmux
        tmux switch-client -t $sessname || tmux new-session -d -s $sessname -c ~/Documents/notatki/ "nvim ."
        tmux switch-client -t $sessname
    else
        tmux attach-session -t $sessname || tmux new-session -s $sessname -c ~/Documents/notatki/ "nvim ."
    end
end

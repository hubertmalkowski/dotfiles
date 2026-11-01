function dotfiles

    set -l sessname "dotfiles"

    if in_tmux
        tmux switch-client -t $sessname || tmux new-session -d -s $sessname -c ~/dotfiles/ "nvim ."
        tmux switch-client -t $sessname
    else
        tmux attach-session -t $sessname || tmux new-session -s $sessname -c ~/dotfiles/ "nvim ."
    end
end

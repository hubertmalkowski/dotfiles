function dotfiles

    set -l sessname "dotfiles"

    if in_tmux
        tmux switch -t $sessname || tmux new -d -s $sessname -c ~/dotfiles/ "nvim ."
        tmux switch -t $sessname
    else
        tmux attach -t $sessname || tmux new -s $sessname -c ~/dotfiles/ "nvim ."
    end
end

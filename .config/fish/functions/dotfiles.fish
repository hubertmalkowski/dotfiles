function dotfiles

    set -l sessname "dotfiles"

    if in_tmux
        tmux switch -t $sessname || tmux new -d -a -s $sessname -c ~/dotfiles/ "nvim ."
    else
        tmux attach -t $sessname || tmux new -s $sessname -c ~/dotfiles/ "nvim ."
    end
end

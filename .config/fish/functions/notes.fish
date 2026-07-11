function notes

    set -l sessname "notes"

    if in_tmux
        tmux switch -t $sessname || tmux new -d -s $sessname -c ~/Okieneczko/ "nvim hello.md"
        tmux switch -t $sessname
    else
        tmux attach -t $sessname || tmux new -s $sessname -c ~/Okieneczko/ "nvim hello.md"
    end
end

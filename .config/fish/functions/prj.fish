function prj --description "Project jumper"
    if not command -q fzf
        echo >&2 "prj: fzf command not found. Install with your OS package manager."
        return 1
    end
    if set -q ZELLIJ
        echo >&2 "FIRST THINGS FIRST detach from current session" \((set_color red )ALT D(set_color normal)\)
        return 1
    end

    # determine the project home
    set -q MY_PROJECTS || set -l MY_PROJECTS ~/Dev  
    set -l prjfolders (path resolve $MY_PROJECTS/*/*/)
    # use fzf to navigate to a project
    set -l prjlist (string replace $MY_PROJECTS/ "" $prjfolders)
    set -l selection (printf '%s\n' $prjlist | fzf --layout=reverse-list --query="$argv" --padding="1,0" --layout="reverse" --height="20" --no-separator --tmux="center")
    test $status -eq 0 || return $status

    cd $MY_PROJECTS/$selection
    set -l sessname (string replace / - $selection)

    # -d flag only if in a tmux session

    if in_tmux
        tmux switch -t $sessname || tmux new -d -s $sessname tmux_dev
        tmux switch -t $sessname
    else
        tmux attach -t $sessname || tmux new -s $sessname tmux_dev
    end

end

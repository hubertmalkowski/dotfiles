set -g __pg_dir (test -n "$XDG_RUNTIME_DIR"; and echo $XDG_RUNTIME_DIR; or echo /tmp)/pg-dev-$USER

function __pg_prune
    # drop registrations of shells that no longer exist
    for pid in (command ls $__pg_dir 2>/dev/null)
        kill -0 $pid 2>/dev/null; or rm -f $__pg_dir/$pid
    end
end

function __pg_acquire
    mkdir -p $__pg_dir
    __pg_prune
    touch $__pg_dir/$fish_pid
end

function __pg_release
    rm -f $__pg_dir/$fish_pid
    __pg_prune
    if test (count (command ls $__pg_dir 2>/dev/null)) -eq 0
        podman stop pg-dev >/dev/null 2>&1
    end
end

function __pg_on_change --on-variable PG_DEV
    if set -q PG_DEV
        __pg_acquire
    else if test -e $__pg_dir/$fish_pid
        __pg_release
    end
end

function __pg_on_exit --on-event fish_exit
    if test -e $__pg_dir/$fish_pid
        __pg_release
    end
end

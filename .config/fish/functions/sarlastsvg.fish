
function sarlastsvg
    set -l out /tmp/disk-(date +%H%M%S).svg
    sadf -g -- -d -s (date -d '15 minutes ago' +%H:%M:%S) > $out
    echo "Saved: $out"
end

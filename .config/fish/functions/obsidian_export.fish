#!/usr/bin/env fish

if test (count $argv) -lt 1
    echo "Usage: "(status filename)" <note-path> [output.tar.gz]"
    echo "Example: "(status filename)" notes/Szeregi"
    exit 1
end

set note_input $argv[1]

if test (count $argv) -ge 2
    set output_file $argv[2]
else
    set output_file export.tar.gz
end

# Add .md if missing
if not string match -q "*.md" $note_input
    set note_input "$note_input.md"
end

set vault_path (obsidian vault info=path 2>/dev/null | string trim)

if test -z "$vault_path"
    echo "Error: could not get vault path. Is Obsidian running?"
    exit 1
end

set -l visited
set -l queue $note_input
set -l to_archive

while test (count $queue) -gt 0
    set current $queue[1]
    set queue $queue[2..]

    if contains -- $current $visited
        continue
    end

    set visited $visited $current

    if not test -f "$vault_path/$current"
        echo "Warning: not found: $current"
        continue
    end

    set to_archive $to_archive $current

    set links (obsidian links path="$current" 2>/dev/null)

    for link in $links
        # Strip heading/block anchors
        set link (string replace -r '#.*$' '' $link | string trim)

        if test -z "$link"
            continue
        end

        if not string match -q "*.md" $link
            set link "$link.md"
        end

        if not contains -- $link $visited
            set queue $queue $link
        end
    end
end

if test (count $to_archive) -eq 0
    echo "No files collected."
    exit 1
end

set temp_dir (mktemp -d)

for file in $to_archive
    set dir_part (dirname $file)
    mkdir -p "$temp_dir/$dir_part"
    cp "$vault_path/$file" "$temp_dir/$file"
end

tar -czf $output_file -C $temp_dir .
rm -rf $temp_dir

echo "Created $output_file with "(count $to_archive)" file(s):"
for f in $to_archive
    echo "  $f"
end

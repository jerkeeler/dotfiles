function trash --description "Move files/folders to macOS Trash"
    if test (count $argv) -eq 0
        echo "Usage: trash <file|folder> [file|folder ...]"
        return 1
    end

    for item in $argv
        if not test -e $item
            echo "trash: $item: No such file or directory"
            continue
        end

        set -l abs_path (realpath $item)
        osascript -e "tell application \"Finder\" to delete POSIX file \"$abs_path\"" >/dev/null
        and echo "Trashed: $item"
        or echo "Failed to trash: $item"
    end
end

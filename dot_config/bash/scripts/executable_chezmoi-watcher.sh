#!/usr/bin/env bash

WATCHED_DIRS=(
    "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
    "${XDG_CONFIG_HOME:-$HOME/.config}/doom"
    "${XDG_CONFIG_HOME:-$HOME/.config}/quickshell"
)

declare -A last_event_time

is_temporary_keepfile() {
    local file=$1
    if [[ "$(basename "$file")" == ".keep" ]]; then
        local now=$(date +%s)
        if [[ ! -e "$file" ]]; then
            return 1
        fi
        local mtime=$(stat -c %Y "$file")
        local age=$((now - mtime))
        if ((age < 3)); then
            return 0
        fi
    fi
    return 1
}

inotifywait -m -r -e create -e modify --format '%w%f' "${WATCHED_DIRS[@]}" | while read -r changed_file; do
    rel_path="${changed_file/#$HOME\//}"

    now=$(date +%s)
    last=${last_event_time["$rel_path"]:-0}

    if ((now - last < 2)); then
        continue
    fi

    last_event_time["$rel_path"]=$now

    if [[ ! -e "$changed_file" ]]; then
        echo "File $changed_file no longer exists, skipping"
        continue
    fi

    if is_temporary_keepfile "$changed_file"; then
        echo "Ignored temporary .keep file: $rel_path"
        continue
    fi

    if chezmoi managed | grep -qxF "$rel_path"; then
        if chezmoi re-add "$rel_path"; then
            notify-send "Chezmoi" "File $rel_path updated"
        else
            notify-send "Chezmoi" "Error during re-add $rel_path"
        fi
    else
        if chezmoi add "$rel_path"; then
            notify-send "Chezmoi" "File $rel_path added"
        else
            notify-send "Chezmoi" "Error during add $rel_path"
        fi
    fi
done

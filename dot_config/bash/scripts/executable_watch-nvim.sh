#!/usr/bin/env bash

WATCHED_DIR="$XDG_CONFIG_HOME/nvim"

while inotifywait -e create -e modify -r "$WATCHED_DIR"; do
    chezmoi re-add "$WATCHED_DIR"
done

echo "inotifywait encountered an error, exiting the script"
notify-send "inotifywait encountered an error, exiting the script"
exit 1

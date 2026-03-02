#!/usr/bin/env bash

active=$(hyprctl activewindow -j | jq -r '.workspace.name | split(":") | if length > 1 then .[1] else "" end')

if [[ ${#active} -gt 0 ]]; then
    hyprctl dispatch togglespecialworkspace "$active"
    exit 0
fi

exit 1

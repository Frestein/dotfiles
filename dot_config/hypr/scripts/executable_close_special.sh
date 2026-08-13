#!/usr/bin/env sh

WORKSPACE_CURRENT=$(hyprctl activewindow -j | jq -r '.workspace.name | split(":") | if length > 1 then .[1] else "" end')

if [ ${#WORKSPACE_CURRENT} -gt 0 ]; then
    hyprctl dispatch "hl.dsp.workspace.toggle_special('$WORKSPACE_CURRENT')"
    exit 0
fi

exit 1

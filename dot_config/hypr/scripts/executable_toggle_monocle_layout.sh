#!/usr/bin/env sh

WORKSPACE_CURRENT=$(hyprctl activeworkspace -j | jq -r '.id')
LAYOUT_CURRENT=$(hyprctl activeworkspace | grep 'tiledLayout:' | awk '{print $2}')

if [ "$LAYOUT_CURRENT" = "monocle" ]; then
    NEW_LAYOUT="dwindle"
else
    NEW_LAYOUT="monocle"
fi

hyprctl eval 'hl.workspace_rule({ workspace = "'$WORKSPACE_CURRENT'", layout = "'$NEW_LAYOUT'" })'

pkill -SIGRTMIN+10 waybar

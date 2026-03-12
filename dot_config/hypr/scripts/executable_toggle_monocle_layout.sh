#!/usr/bin/env sh

WORKSPACE_CURRENT=$(hyprctl activeworkspace -j | jq -r '.id')
LAYOUT_CURRENT=$(hyprctl activeworkspace | grep 'tiledLayout:' | awk '{print $2}')

if [ "$LAYOUT_CURRENT" = "monocle" ]; then
    hyprctl keyword workspace "$WORKSPACE_CURRENT, layout:dwindle"
else
    hyprctl keyword workspace "$WORKSPACE_CURRENT, layout:monocle"
fi

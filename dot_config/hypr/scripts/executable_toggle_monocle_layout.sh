#!/usr/bin/env bash

CURRENT_WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')

CURRENT_LAYOUT=$(hyprctl activeworkspace | grep 'tiledLayout:' | awk '{print $2}')

if [ "$CURRENT_LAYOUT" = "monocle" ]; then
    hyprctl keyword workspace "$CURRENT_WORKSPACE, layout:dwindle"
    # notify-send "Workspace $CURRENT_WORKSPACE" "Layout: dwindle"
else
    hyprctl keyword workspace "$CURRENT_WORKSPACE, layout:monocle"
    # notify-send "Workspace $CURRENT_WORKSPACE" "Layout: monocle"
fi

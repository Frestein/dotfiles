#!/usr/bin/env sh

LAYOUT=$(hyprctl activeworkspace -j | jq -r '.tiledLayout')

if [ "$LAYOUT" = "monocle" ]; then
    echo '{"text": " Monocle", "tooltip": "Layout: monocle"}'
else
    echo '{"text": " Dwindle", "tooltip": "Layout: dwindle"}'
fi

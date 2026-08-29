#!/usr/bin/env sh

LAYOUT=$(hyprctl activeworkspace -j | jq -r '.tiledLayout')

if [ "$LAYOUT" = "monocle" ]; then
	echo '{"text": " Monocle", "tooltip": "Change to Dwindle"}'
else
	echo '{"text": " Dwindle", "tooltip": "Change to Monocle"}'
fi

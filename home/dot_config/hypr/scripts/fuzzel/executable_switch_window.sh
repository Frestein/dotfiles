#!/usr/bin/env sh

set -e

STATE=$(hyprctl -j clients)
WINDOW_CURRENT=$(hyprctl -j activewindow)

ADDRESS_CURRENT=$(echo "$WINDOW_CURRENT" | jq -r '.address')

SELECT_WINDOW=$(echo "$STATE" | jq -r --arg current "$ADDRESS_CURRENT" '
    [ .[] | select(.monitor != -1) |
        ( .class | split(".") | last | gsub("_"; "-") | if . == "footclient" then "foot" else . end ) as $icon |
        ( if .address == $current then .workspace.name + " [focused]" else .workspace.name end ) as $display_ws |
        ( if .workspace.name | startswith("special") then 1 else 0 end ) as $group |
        {
            sort_key: "\($group)_\(.workspace.name)",
            address: .address,
            workspace: .workspace.name,
            display_ws: $display_ws,
            title: .title,
            icon: $icon
        }
    ] | sort_by(.sort_key) | .[] |
    "\(.address)\t\(.workspace)\t\(.display_ws)\t\(.title)@icon@\(.icon)"
' | sed -e 's|@icon@|\x0icon\x1f|' |
    fuzzel -d \
        --minimal-lines \
        -p " " \
        --placeholder "Choose window" \
        -w 85 \
        --match-nth=2 \
        --with-nth="{3} {4}")

ADDRESS_FOCUSED=$(echo "$SELECT_WINDOW" | awk '{print $1}')
WORKSPACE_FOCUSED=$(echo "$SELECT_WINDOW" | awk '{print $2}')

IS_FULLSCREEN=$(echo "$STATE" | jq -r ".[] | select(.fullscreen > 0)  | select(.workspace.name == \"$WORKSPACE_FOCUSED\") | .address")

if [ -n "$SELECT_WINDOW" ]; then
    if [ -z "$IS_FULLSCREEN" ]; then
        hyprctl dispatch 'hl.dsp.focus({ window = "address:'"$ADDRESS_FOCUSED"'" })'
    else
        hyprctl dispatch 'hl.dsp.focus({ window = "address:'"$IS_FULLSCREEN"'" })'
        hyprctl dispatch 'hl.dsp.window.fullscreen({ action = "disable" })'
        hyprctl dispatch 'hl.dsp.focus({ window = "address:'"$ADDRESS_FOCUSED"'" })'
        hyprctl dispatch 'hl.dsp.window.fullscreen({ action = "enable" })'
    fi
fi

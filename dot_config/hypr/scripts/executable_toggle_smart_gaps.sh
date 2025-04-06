#!/bin/sh

# Get active workspace id
id=$(hyprctl -j activeworkspace | jq ".id")

# Set range variable in order to match the workspace (not working by id only)
rid="r[$id-$id]"

# Current gaps for active workspace
gaps_in_current=$(hyprctl workspacerules -j | jq --arg rid "$rid" '[.[] | select(.workspaceString | startswith($rid)) | .gapsIn[0]] | .[0]')
gaps_out_current=$(hyprctl workspacerules -j | jq --arg rid "$rid" '[.[] | select(.workspaceString | startswith($rid)) | .gapsOut[0]] | .[0]')

# Toggle gaps for the active workspace
if [ "$gaps_in_current" = "null" ] && [ "$gaps_out_current" = "null" ]; then
    hyprctl keyword workspace "$rid" f[1], gapsin:0, gapsout:0
    hyprctl keyword workspace "$rid" w[tv1], gapsin:0, gapsout:0
    exit
fi

hyprctl reload

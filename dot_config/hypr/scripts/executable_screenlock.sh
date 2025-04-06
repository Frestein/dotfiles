#!/usr/bin/env dash

hypr="$XDG_CONFIG_HOME/hypr"

"$hypr/scripts/mpris_inhibitor.sh" || exit 1

hyprlock

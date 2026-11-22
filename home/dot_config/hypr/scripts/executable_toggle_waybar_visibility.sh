#!/usr/bin/env sh

# Toggle waybar visibility and keep the shared state file in sync, so the
# autohide loop and manual toggles agree on the bar's visibility.

STATE="/run/user/$(id -u)/waybar-autohide.state"

if [ "$(cat "$STATE" 2>/dev/null)" = "hidden" ]; then
	echo shown >"$STATE"
else
	echo hidden >"$STATE"
fi

pkill -USR1 waybar

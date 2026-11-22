#!/usr/bin/env sh

# Force waybar visible if the shared state says it is hidden; run as the
# autohide service's ExecStopPost so disabling autohide never leaves the
# bar stuck off-screen.

STATE="/run/user/$(id -u)/waybar-autohide.state"

if [ "$(cat "$STATE" 2>/dev/null)" = "hidden" ]; then
	echo shown >"$STATE"
	pkill -USR1 waybar
fi

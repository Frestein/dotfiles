#!/usr/bin/env sh
# Toggle waybar autohide lock: creates/removes lock file and signals waybar to update

LOCK="/run/user/$(id -u)/waybar-autohide.lock"

if [ -f "$LOCK" ]; then
    rm -f "$LOCK"
else
    touch "$LOCK"
fi

pkill -SIGRTMIN+8 waybar

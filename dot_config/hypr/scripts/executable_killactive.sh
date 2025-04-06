#!/usr/bin/env dash

LOCK_FILE="/tmp/killactive.lock"
TIMEOUT=300

if [ -f "$LOCK_FILE" ]; then
    rm -f "$LOCK_FILE"
    hyprctl dispatch killactive
    exit 0
fi

touch "$LOCK_FILE"
(
    sleep "$(echo "$TIMEOUT / 1000" | bc -l)"
    rm -f "$LOCK_FILE"
) &

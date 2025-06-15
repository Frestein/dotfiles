#!/usr/bin/env dash

LOCK_FILE="/tmp/killactive.lock"
TIMEOUT=300

(
    flock -n 9 || {
        hyprctl dispatch killactive
        exit 0
    }

    sleep $((TIMEOUT / 1000)).$((TIMEOUT % 1000))

) 9>"$LOCK_FILE"

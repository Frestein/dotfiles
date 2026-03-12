#!/usr/bin/env sh

send_notify() {
    notify-send -u "$1" -h string:x-dunst-stack-tag:bluelight "Bluelight" "$2"
}

if ! command -v hyprsunset >/dev/null 2>&1; then
    send_notify critical "hyprsunset not found"
    exit 1
fi

PID=$(pgrep -x hyprsunset)

if [ -z "$PID" ]; then
    hyprsunset &
    send_notify low "Started"
else
    kill "$PID"
    send_notify low "Stopped"
fi

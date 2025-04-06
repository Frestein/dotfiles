#!/usr/bin/env dash

notify_cmd='notify-send -u low -h string:x-dunst-stack-tag:bluelight'

notify_user() {
    eval "$notify_cmd 'Bluelight: $1'"
}

pid=$(pgrep -x hyprsunset)

if [ "$pid" = "" ]; then
    hyprsunset &
    notify_user "Started"
else
    kill "$pid"
    notify_user "Stopped"
fi

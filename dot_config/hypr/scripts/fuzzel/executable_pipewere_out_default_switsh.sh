#!/usr/bin/env dash

pactl set-default-sink "$(pactl list short sinks | awk '{print $2}' | fuzzel -d -p 'Switch Output ')"

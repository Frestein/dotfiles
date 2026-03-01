#!/usr/bin/env bash

direction="$1"

if [[ ! "$direction" =~ ^[lrud]$ ]]; then
    echo "Usage: $0 {l|r|u|d}" >&2
    exit 1
fi

current_layout=$(hyprctl activeworkspace | grep 'tiledLayout:' | awk '{print $2}')

if [ "$current_layout" = "monocle" ]; then
    case "$direction" in
    r | d) hyprctl dispatch layoutmsg cyclenext ;;
    l | u) hyprctl dispatch layoutmsg cycleprev ;;
    esac
else
    if hyprctl activewindow | grep -q "fullscreen: 2"; then
        case "$direction" in
        r | d) hyprctl dispatch cyclenext ;;
        l | u) hyprctl dispatch cyclenext prev ;;
        esac
    else
        hyprctl dispatch movefocus "$direction"
    fi
fi

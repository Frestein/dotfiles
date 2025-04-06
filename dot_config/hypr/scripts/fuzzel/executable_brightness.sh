#!/usr/bin/env dash

get_brightness() {
    ddcutil getvcp 10 | awk '/current/ {gsub(/,/, "", $9); print $9}'
}

set_brightness() {
    ddcutil setvcp 10 "$1" && echo "$1" >"$WOBSOCK" && pkill -SIGRTMIN+9 waybar
}

new_brightness=$(fuzzel -d -w 15 --anchor top --y-margin 20 \
    --prompt-only "Brightness ")

if [ "$new_brightness" != "" ]; then
    if [ "$new_brightness" -ge 0 ] && [ "$new_brightness" -le 100 ] 2>/dev/null; then
        set_brightness "$new_brightness"
    else
        get_brightness >"$WOBSOCK"
    fi
fi

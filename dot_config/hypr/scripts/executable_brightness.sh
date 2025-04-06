#!/usr/bin/env dash

get_brightness() {
    ddcutil getvcp 10 | awk '/current/ {gsub(/,/, "", $9); print $9}'
}

update_brightness() {
    brightness=$(get_brightness)
    echo "$brightness" >"$WOBSOCK"
    pkill -SIGRTMIN+9 waybar
}

inc_brightness() {
    ddcutil setvcp 10 + 25 && update_brightness
}

dec_brightness() {
    ddcutil setvcp 10 - 25 && update_brightness
}

case "$1" in
--get)
    get_brightness
    ;;
--inc)
    inc_brightness
    ;;
--dec)
    dec_brightness
    ;;
*)
    echo "$(get_brightness)%"
    update_brightness
    ;;
esac

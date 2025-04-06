#!/usr/bin/env dash

get_vol() {
    wpctl get-volume @DEFAULT_SINK@ | awk '{
        gsub(/[^0-9.]/, "", $2)
        print int($2 * 100)
    }'
}

send_cur_vol_socket() {
    vol=$(get_vol)
    echo "$vol" >"$WOBSOCK"
}

inc_vol() {
    if wpctl get-volume @DEFAULT_SINK@ | grep -q MUTED; then
        wpctl set-mute @DEFAULT_SINK@ 0
    fi
    wpctl set-volume @DEFAULT_SINK@ 5%+ -l 1.0 && send_cur_vol_socket
}

dec_vol() {
    if wpctl get-volume @DEFAULT_SINK@ | grep -q MUTED; then
        wpctl set-mute @DEFAULT_SINK@ 0
    fi
    wpctl set-volume @DEFAULT_SINK@ 5%- -l 1.0 && send_cur_vol_socket
}

toggle_mute() {
    wpctl set-mute @DEFAULT_SINK@ toggle
    if wpctl get-volume @DEFAULT_SINK@ | grep -q MUTED; then
        echo 0 >"$WOBSOCK"
    else
        send_cur_vol_socket
    fi
}

case "$1" in
--get)
    get_vol
    ;;
--inc)
    inc_vol
    ;;
--dec)
    dec_vol
    ;;
--toggle)
    toggle_mute
    ;;
*)
    echo "$(get_vol)%"
    ;;
esac

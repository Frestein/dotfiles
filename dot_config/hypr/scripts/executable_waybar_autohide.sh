#!/usr/bin/env bash

HIDDEN="true"
SCREEN_WIDTH=1920
TOLERANCE=10

CENTER_X=$((SCREEN_WIDTH / 2))

while true; do
    sleep 0.1

    fullscreen=$(hyprctl activewindow | grep "fullscreen:" | awk '{print $2}')
    if [[ "$fullscreen" -ne 0 ]]; then
        continue
    fi

    coords=$(hyprctl cursorpos)
    coords_clean=$(echo "$coords" | tr -d ' ')
    x=${coords_clean%%,*}
    y=${coords_clean##*,}

    if [[ -z "$x" || -z "$y" ]]; then
        continue
    fi

    is_near() {
        local val=$1
        local target=$2
        local tol=$3
        local diff=$((val > target ? val - target : target - val))
        [[ $diff -le $tol ]]
    }

    near_left=false
    near_right=false
    near_center=false

    if is_near "$x" 0 "$TOLERANCE" && is_near "$y" 0 "$TOLERANCE"; then
        near_left=true
    fi

    if is_near "$x" "$SCREEN_WIDTH" "$TOLERANCE" && is_near "$y" 0 "$TOLERANCE"; then
        near_right=true
    fi

    if is_near "$x" "$CENTER_X" "$TOLERANCE" && is_near "$y" 0 "$TOLERANCE"; then
        near_center=true
    fi

    if { [[ "$near_left" == true ]] || [[ "$near_right" == true ]] || [[ "$near_center" == true ]]; } && [[ "$HIDDEN" == "true" ]]; then
        pkill -USR1 waybar
        HIDDEN="false"
    elif ((y > 250)) && [[ "$HIDDEN" == "false" ]]; then
        pkill -USR1 waybar
        HIDDEN="true"
    fi
done

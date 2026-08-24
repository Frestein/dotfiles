#!/usr/bin/env sh

# Auto-hide waybar based on cursor position and fullscreen state
# When cursor near top edge (left/right/center) -> show waybar
# When cursor moves down (y > 250) -> hide waybar

send_notify() {
    notify-send -u "$1" -h string:x-dunst-stack-tag:waybar "Waybar" "$2"
}

if ! command -v waybar >/dev/null 2>&1; then
    send_notify critical "waybar not found"
    exit 1
fi

HIDDEN="true"     # Current visibility state of waybar
SCREEN_WIDTH=1920 # Screen width in pixels
TOLERANCE=10      # Allowed pixel deviation from edges

CENTER_X=$((SCREEN_WIDTH / 2))

# Check if a value is within tolerance of a target
is_near() {
    _val=$1
    _target=$2
    _tol=$3
    if [ "$_val" -gt "$_target" ]; then
        _diff=$((_val - _target))
    else
        _diff=$((_target - _val))
    fi
    [ "$_diff" -le "$_tol" ]
}

while true; do
    LOCK="/run/user/$(id -u)/waybar-autohide.lock"

    # If lock file exists, skip this iteration (prevents multiple instances)
    if [ -f "$LOCK" ]; then
        continue
    fi

    sleep 0.1

    # Don't trigger if current window is fullscreen
    fullscreen=$(hyprctl activewindow | grep "fullscreen:" | awk '{print $2}')
    if [ "$fullscreen" -ne 0 ]; then
        continue
    fi

    # Get cursor coordinates (format: "x, y")
    coords=$(hyprctl cursorpos)
    coords_clean=$(echo "$coords" | tr -d ' ')
    x=${coords_clean%%,*}
    y=${coords_clean##*,}

    if [ -z "$x" ] || [ -z "$y" ]; then
        continue
    fi

    near_left=false
    near_right=false
    near_center=false

    # Check if cursor is near top-left corner
    if is_near "$x" 0 "$TOLERANCE" && is_near "$y" 0 "$TOLERANCE"; then
        near_left=true
    fi

    # Check if cursor is near top-right corner
    if is_near "$x" "$SCREEN_WIDTH" "$TOLERANCE" && is_near "$y" 0 "$TOLERANCE"; then
        near_right=true
    fi

    # Check if cursor is near top-center
    if is_near "$x" "$CENTER_X" "$TOLERANCE" && is_near "$y" 0 "$TOLERANCE"; then
        near_center=true
    fi

    # Show waybar if cursor is near top edge and currently hidden
    if { [ "$near_left" = true ] || [ "$near_right" = true ] || [ "$near_center" = true ]; } && [ "$HIDDEN" = true ]; then
        pkill -USR1 waybar
        HIDDEN=false
    # Hide waybar if cursor moves down (y > 250) and currently shown
    elif [ "$y" -gt 250 ] && [ "$HIDDEN" = false ]; then
        pkill -USR1 waybar
        HIDDEN=true
    fi
done

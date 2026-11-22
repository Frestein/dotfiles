#!/usr/bin/env sh

# Auto-hide waybar based on cursor position and fullscreen state
# When cursor near the top edge of a monitor (left/right/center) -> show waybar
# When cursor moves down (y > 250) -> hide waybar

send_notify() {
	notify-send -u "$1" -h string:x-dunst-stack-tag:waybar "Waybar" "$2"
}

if ! command -v waybar >/dev/null 2>&1; then
	send_notify critical "waybar not found"
	exit 1
fi

LOCK="/run/user/$(id -u)/waybar-autohide.lock"
HIDDEN="true" # Current visibility state of waybar
TOLERANCE=10  # Allowed pixel deviation from the monitor edges

# Monitors will be reported in logical layout coordinates, refreshed every 5 s
MONITORS_JSON=""
CACHE_TICKS=0

refresh_monitors() {
	MONITORS_JSON=$(hyprctl monitors -j 2>/dev/null)
	CACHE_TICKS=50
}

# Print "left right top center" of the monitor under the cursor;
# empty when the cursor is inside no monitor
monitor_at() {
	_x=$1
	_y=$2
	printf '%s' "$MONITORS_JSON" | jq -r --argjson _x "$_x" --argjson _y "$_y" '
        .[] | select($_x >= .x and $_x < .x + .width and $_y >= .y and $_y < .y + .height)
        | "\(.x) \(.x + .width) \(.y) \(.x + .width / 2)"
    ' | head -n1
}

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
	sleep 0.1

	# If lock file exists, skip this iteration (prevents multiple instances)
	if [ -f "$LOCK" ]; then
		continue
	fi

	# Don't trigger if current window is fullscreen
	fullscreen=$(hyprctl activewindow | grep "fullscreen:" | awk '{print $2}')
	if [ "${fullscreen:-0}" -ne 0 ]; then
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

	if [ "$CACHE_TICKS" -le 0 ]; then
		refresh_monitors
	else
		CACHE_TICKS=$((CACHE_TICKS - 1))
	fi

	geometry=$(monitor_at "$x" "$y")
	if [ -z "$geometry" ]; then
		continue
	fi
	set -- $geometry
	edge_left=$1
	edge_right=$2
	edge_top=$3
	center_x=$4

	near_left=false
	near_right=false
	near_center=false

	# Check if cursor is near top-left corner
	if is_near "$x" "$edge_left" "$TOLERANCE" && is_near "$y" "$edge_top" "$TOLERANCE"; then
		near_left=true
	fi

	# Check if cursor is near top-right corner
	if is_near "$x" "$edge_right" "$TOLERANCE" && is_near "$y" "$edge_top" "$TOLERANCE"; then
		near_right=true
	fi

	# Check if cursor is near top-center
	if is_near "$x" "$center_x" "$TOLERANCE" && is_near "$y" "$edge_top" "$TOLERANCE"; then
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

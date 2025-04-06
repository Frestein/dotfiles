#!/usr/bin/env dash

SCREENSHOTS_DIR="$(xdg-user-dir PICTURES)/Screenshots"
NOTIFY_CMD="notify-send -h string:x-dunst-stack-tag:screenshot"
DATE_FORMAT="C%H.%M.%S-D%m.%d.%Y"
HYPRSHOT_OPTS="-F ppm --raw --freeze"
DEFAULT_DISPLAY="HDMI-A-2"
MAX_DELAY=9

init() {
	[ -d "$SCREENSHOTS_DIR" ] || mkdir -p "$SCREENSHOTS_DIR"
}

notify() {
	local timeout="${1:-1000}"
	local msg="$2"
	$NOTIFY_CMD -t "$timeout" "$msg"
}

countdown() {
    for sec in $(seq "$1" -1 1); do
        notify 1000 "Taking shot in: $sec"
        sleep 1
    done
}

capture() {
	local mode="$1"
	local extra_args="${2:-}"
	local timestamp
	timestamp=$(date +"$DATE_FORMAT")
	local file="$SCREENSHOTS_DIR/${timestamp}.png"

	hyprshot -m "$mode" $HYPRSHOT_OPTS "$extra_args" | satty --filename - --output-filename "$file"
}

capture_output() {
	capture output "-m $DEFAULT_DISPLAY"
}

capture_window() {
	capture window "${1:-}"
}

capture_region() {
	capture region
}

capture_with_delay() {
	local delay="${1:-3}"
	countdown "$delay"
	sleep 0.5
	capture_output
}

usage() {
	cat <<EOF
Screenshot tool

Usage: ${0##*/} [OPTION]

Options:
  --now         Capture immediately
  --delay [1-$MAX_DELAY] Capture with delay
  --win         Capture window
  --active      Capture active window
  --area        Capture selected region
  --help        Show this help
EOF
}

main() {
	init

	case "$1" in
	--now) capture_output ;;
	--delay)
		if [ "$2" != "" ] && [ "$2" -ge 1 ] && [ "$2" -le "$MAX_DELAY" ]; then
			capture_with_delay "$2"
		fi
		;;
	--win) capture_window ;;
	--active) capture_window "-m active" ;;
	--area) capture_region ;;
	--help | -h) usage ;;
	*)
		if [ "$1" = "" ]; then
			usage
		else
			notify 5000 "Invalid option: $1"
			echo "Invalid option: $1"
		fi
		;;
	esac
}

main "$@"
exit $?

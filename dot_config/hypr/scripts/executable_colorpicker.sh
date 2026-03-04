#!/usr/bin/env sh

if ! command -v hyprpicker >/dev/null 2>&1; then
    notify-send -u critical -h string:x-dunst-stack-tag:colorpicker "Color Picker" "hyprpicker not found"
    exit 1
fi

color=$(hyprpicker -a)

if [ "$color" ]; then
    image=$(mktemp -t colorpicker-XXXXXX.png)

    # Generate preview
    magick -size 48x48 xc:"$color" "$image"

    # Send notification with color
    notify-send -u low -h string:x-dunst-stack-tag:colorpicker -i "$image" "$color, copied to clipboard."

    # Remove temporary preview
    (sleep 1 && rm -f "$image") &
fi

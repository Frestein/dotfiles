#!/usr/bin/env sh

if ! command -v hyprpicker >/dev/null 2>&1; then
    notify-send -u critical -h string:x-dunst-stack-tag:colorpicker "Color Picker" "hyprpicker not found"
    exit 1
fi

if ! command -v magick >/dev/null 2>&1; then
    hyprpicker -a -n
else
    COLOR=$(hyprpicker -a)

    if [ "$COLOR" ]; then
        IMAGE=$(mktemp -t colorpicker-XXXXXX.png)

        # Generate preview
        magick -size 48x48 xc:"$COLOR" "$IMAGE"

        # Send notification with color
        notify-send -u low -h string:x-dunst-stack-tag:colorpicker -i "$IMAGE" "$COLOR, copied to clipboard."

        # Remove temporary preview
        (sleep 1 && rm -f "$IMAGE") &
    fi
fi

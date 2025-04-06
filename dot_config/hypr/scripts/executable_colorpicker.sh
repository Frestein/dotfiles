#!/usr/bin/env dash

color=$(hyprpicker)
image="/tmp/$color.png"

if [ "$color" ]; then
    # Copy color code to clipboard
    echo "$color" | tr -d "\n" | wl-copy
    # Generate preview
    magick -size 48x48 xc:"$color" "$image"
    # Send notification with color
    notify-send -u low -h string:x-dunst-stack-tag:colorpicker -i "$image" "$color, copied to clipboard."
fi

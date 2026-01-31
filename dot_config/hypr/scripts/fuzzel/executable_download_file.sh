#!/usr/bin/env dash
# A fuzzel utility to download files from various sites & types
#
# Requirements:
# - wl-clipboard: for clipboard access (wl-paste)
# - yt-dlp: for downloading videos and audio from various sites
# - aria2: for fast downloading (external downloader)
# - fuzzel: a fuzzy finder menu similar to rofi for selecting directories and options
#
# Ensure all dependencies are installed before running the script.

fuzzel_defaults="-d"

send_notify() {
    local message="$1"
    echo "$message"
    notify-send -u low -h string:x-dunst-stack-tag:downloader "$message"
}

# Check for required commands
command -v wl-paste >/dev/null || {
    send_notify "Error: wl-clipboard is not installed."
    exit 1
}
command -v yt-dlp >/dev/null || {
    send_notify "Error: yt-dlp is not installed."
    exit 1
}
command -v aria2c >/dev/null || {
    send_notify "Error: aria2 is not installed."
    exit 1
}
command -v fuzzel >/dev/null || {
    send_notify "Error: fuzzel is not installed."
    exit 1
}

# Get Link
if [ "$1" = "" ]; then
    link=$(wl-paste)
else
    link="$1"
fi

# Check if link is empty
if [ "$link" = "" ]; then
    send_notify "Error: No link provided. Please provide a link as an argument or copy it to the clipboard."
    exit 1
fi

# Validate if the link is a valid URL or a magnet link
if ! echo "$link" | grep -qE '^(http|https)://|^magnet:'; then
    # Additional check for absolute path to the torrent file
    if [ ! -f "$link" ]; then
        send_notify "Error: The provided input is not a valid URL, magnet link, or file path."
        exit 1
    fi
else
    echo "The provided input is a valid URL or magnet link."
fi

echo "Link: $link"

# Get Directory
if [ "$2" = "" ]; then
    # Add your own directories below
    dirlist=$(find -L "$HOME/Documents/Books" "$HOME" "/var/games" -type d -maxdepth 2 ! -name '.*' 2>/dev/null)
    dir=$(echo "$dirlist" | eval "fuzzel -p 'Download to: ' $fuzzel_defaults")
    [ "$dir" = "" ] && exit 1
    if [ ! -d "$dir" ]; then
        create_directory_option=$(echo "No\nYes" | eval "fuzzel -p '$dir does not exist. Create it? ' -l 2 $fuzzel_defaults")
        if [ "$create_directory_option" = "Yes" ]; then
            mkdir -p "$dir" || {
                send_notify "Error: Failed to create directory '$dir'."
                exit 1
            }
        fi
    fi
else
    dir="$2"
fi

[ "$dir" = "" ] && exit 1
echo "Directory: $dir"
cd "$dir" || {
    send_notify "Error: Failed to change directory to '$dir'."
    exit 1
}

# Log the download attempt
echo "$link\t$dir\t#$(date)" >>~/.downloader_history

# Sort & Download
if yt-dlp -e --abort-on-error "$link" 2>/dev/null; then
    echo "Downloader: Youtube-dl"
    type=$(echo "Video\nAudio" | eval "fuzzel -p 'Download Type: ' -l 2 $fuzzel_defaults")
    if [ "$type" = "Video" ]; then
        send_notify "Starting video download..."
        file=$(yt-dlp -ic --add-metadata "$link" --abort-on-error --external-downloader aria2c --external-downloader-args "-x 16 -s 16 -k 1M" -o "%(title)s.%(ext)s" --get-filename --no-simulate)
    elif [ "$type" = "Audio" ]; then
        send_notify "Starting audio download..."
        file=$(yt-dlp -xic --add-metadata "$link" --abort-on-error --external-downloader aria2c --external-downloader-args "-x 16 -s 16 -k 1M" -o "%(title)s.%(ext)s" --get-filename --no-simulate)
    fi
else
    send_notify "Starting download..."
    aria2c "$link" -x 16 -s 16 -k 1M --seed-time 0
fi

# Notify if download was successful
if [ "$file" = "" ]; then
    notify-send "Error: No file was downloaded."
elif [ -e "$dir/$file" ] && [ -s "$dir/$file" ]; then
    notify-send "Download completed: '$file'."
fi
exit 0

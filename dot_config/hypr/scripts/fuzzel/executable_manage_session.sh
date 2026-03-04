#!/usr/bin/env sh

options="󰗽 Logout\n Lock\n󰯈 Kill mode\n Reload\n Reboot\n Shutdown"

selected_option=$(
    printf "%b" "$options" | fuzzel -d \
        --minimal-lines \
        -p " " \
        --placeholder "Session "
)

command=$(printf "%s\n" "$selected_option" | grep -o -E "[a-zA-Z]+")

main() {
    case "$1" in
    "Logout")
        if uwsm check is-active; then
            uwsm stop
        elif [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ]; then
            if command -v hyprshutdown >/dev/null 2>&1; then
                hyprshutdown
            else
                hyprctl dispatch exit
            fi
        fi
        ;;
    "Lock")
        if [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ]; then
            hyprlock
        fi
        ;;
    "Kill")
        if [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ]; then
            hyprctl kill
        fi
        ;;
    "Reload")
        if [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ]; then
            hyprctl reload
        fi
        pkill -SIGUSR2 waybar
        notify-send -u low -h string:x-dunst-stack-tag:screenshot "Config reloaded"
        ;;
    "Reboot") systemctl reboot ;;
    "Shutdown") systemctl poweroff ;;
    *) return ;;
    esac
}

main "$command"

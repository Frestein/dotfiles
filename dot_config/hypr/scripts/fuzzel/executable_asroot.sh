#!/usr/bin/env dash

hypr="$XDG_CONFIG_HOME/hypr"

run_command() {
    case "$1" in
    "Foot")
        "$hypr/scripts/asroot.sh" foot -e
        ;;
    "Zapret")
        "$hypr/scripts/asroot.sh" foot -e sh -c "cd /opt/zapret && exec fish"
        ;;
    "DNSCrypt")
        "$hypr/scripts/asroot.sh" foot -e sh -c "cd /etc/dnscrypt-proxy && exec fish"
        ;;
    "Etckeeper")
        "$hypr/scripts/asroot.sh" foot -e sh -c "cd /etc && exec fish"
        ;;
    "Neovim")
        "$hypr/scripts/asroot.sh" foot -e nvim
        ;;
    "Yazi")
        "$hypr/scripts/asroot.sh" foot -e yazi
        ;;
    esac
}

options=" Foot\n󰑩 Zapret\n󰒒 DNSCrypt\n Etckeeper\n Neovim\n󰇥 Yazi"
selected_option=$(echo "$options" | fuzzel -d \
    -l 6 \
    -p " " \
    --placeholder "Root ")
command=$(echo "$selected_option" | grep -o -E "[a-zA-Z]+")

run_command "$command"

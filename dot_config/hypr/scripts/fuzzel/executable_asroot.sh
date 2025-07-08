#!/usr/bin/env dash

hypr="$XDG_CONFIG_HOME/hypr"

run_command() {
    case "$1" in
    "Foot")
        "$hypr/scripts/asroot.sh" foot
        ;;
    "Zapret")
        "$hypr/scripts/asroot.sh" foot --working-directory /opt/zapret
        ;;
    "DNSCrypt")
        "$hypr/scripts/asroot.sh" foot --working-directory /etc/dnscrypt-proxy
        ;;
    "Etckeeper")
        "$hypr/scripts/asroot.sh" foot --working-directory /etc
        ;;
    "Neovim")
        "$hypr/scripts/asroot.sh" foot nvim
        ;;
    "Yazi")
        "$hypr/scripts/asroot.sh" foot yazi
        ;;
    esac
}

options=" Foot\n Neovim\n󰇥 Yazi\n󰑩 Zapret\n󰒒 DNSCrypt\n Etckeeper"
selected_option=$(echo "$options" | fuzzel -d \
    -l 6 \
    -p " " \
    --placeholder "Root ")
command=$(echo "$selected_option" | grep -o -E "[a-zA-Z]+")

run_command "$command"

#!/usr/bin/env sh

run_command() {
    case "$1" in
    "Foot") set -- foot ;;
    "Neovim") set -- foot nvim ;;
    "Yazi") set -- foot yazi ;;
    "Zapret") set -- foot --working-directory /opt/zapret ;;
    "DNSCrypt") set -- foot --working-directory /etc/dnscrypt-proxy ;;
    "Etckeeper") set -- foot --working-directory /etc ;;
    *) return ;;
    esac

    asroot "$@"
}

options=" Foot\n Neovim\n󰇥 Yazi\n󰑩 Zapret\n󰒒 DNSCrypt\n Etckeeper"

selected_option=$(printf "%b" "$options" | fuzzel -d \
    --minimal-lines \
    -p " " \
    --placeholder "Root ")

command=$(printf "%s\n" "$selected_option" | grep -o -E "[a-zA-Z]+")

run_command "$command"

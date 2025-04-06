#!/usr/bin/env dash

hypr="$XDG_CONFIG_HOME/hypr"

run_command() {
    case "$1" in
    "Foot")
        "$hypr/scripts/asroot.sh" foot -e
        ;;
    "Neovim")
        "$hypr/scripts/asroot.sh" foot -e nvim
        ;;
    "Yazi")
        "$hypr/scripts/asroot.sh" foot -e yazi
        ;;
    esac
}

options=" Foot\n Neovim\n󰇥 Yazi"
selected_option=$(echo "$options" | fuzzel -d \
    -l 3 \
    -p "Root ")
command=$(echo "$selected_option" | grep -o -E "[a-zA-Z]+")

run_command "$command"

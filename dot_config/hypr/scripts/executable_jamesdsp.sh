#!/usr/bin/env bash

NOTIFY_CMD=(notify-send -h string:x-dunst-stack-tag:jamesdsp)
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/jamesdsp"
STATE_FILE="${STATE_DIR}/preset"
DMENU_CMD="${DMENU:-fuzzel -d}"

toggle_bypass() {
    local state
    state=$(jamesdsp --get master_enable)
    if [ "$state" = "true" ]; then
        jamesdsp --set master_enable=false
        "${NOTIFY_CMD[@]}" "JamesDSP" "Bypass enabled"
    else
        jamesdsp --set master_enable=true
        "${NOTIFY_CMD[@]}" "JamesDSP" "Bypass disabled"
    fi
}

show_current_state() {
    local preset=""
    local bypass_state

    if [ -f "$STATE_FILE" ]; then
        preset=$(cat "$STATE_FILE")
    fi
    [ -z "$preset" ] && preset="(none)"

    bypass_state=$(jamesdsp --get master_enable)
    if [ "$bypass_state" = "false" ]; then
        bypass_state="enabled"
    else
        bypass_state="disabled"
    fi

    "${NOTIFY_CMD[@]}" "JamesDSP" "Bypass: $bypass_state\nPreset: $preset"
}

choose_and_load_preset() {
    mkdir -p "$STATE_DIR"

    local presets
    presets=$(jamesdsp --list-presets)

    local chosen
    chosen=$(printf '%s\n' "$presets" | eval "$DMENU_CMD -l 7") || return 1

    if [ -n "$chosen" ]; then
        jamesdsp --load-preset "$chosen"
        echo "$chosen" >"$STATE_FILE"
        "${NOTIFY_CMD[@]}" "JamesDSP" "Loaded preset: $chosen"
    else
        "${NOTIFY_CMD[@]}" "JamesDSP" "No preset selected"
    fi
}

usage() {
    cat <<EOF
Usage: ${0##*/} [OPTION]...

Options:
  --toggle              Toggle bypass state
  --state               Show current preset and bypass state
  --choose-preset       Show and choose preset
  --help                Show this help

Note: --toggle cannot be used together with --choose-preset.

Multiple options can be combined, except the above restriction.
EOF
}

main() {
    if [ $# -eq 0 ]; then
        usage
        exit 0
    fi

    show_state_flag=false
    choose_preset_flag=false
    toggle_flag=false

    for arg in "$@"; do
        case "$arg" in
        --toggle) toggle_flag=true ;;
        --state) show_state_flag=true ;;
        --choose-preset) choose_preset_flag=true ;;
        --help | -h)
            usage
            exit 0
            ;;
        *)
            "${NOTIFY_CMD[@]}" "JamesDSP" "Invalid option: $arg"
            echo "Invalid option: $arg"
            usage
            exit 1
            ;;
        esac
    done

    if $toggle_flag && $choose_preset_flag; then
        "${NOTIFY_CMD[@]}" "JamesDSP" "Error: --toggle cannot be used with --choose-preset"
        echo "Error: --toggle cannot be used with --choose-preset"
        exit 1
    fi

    $toggle_flag && toggle_bypass
    $show_state_flag && show_current_state
    $choose_preset_flag && choose_and_load_preset
}

main "$@"
exit $?

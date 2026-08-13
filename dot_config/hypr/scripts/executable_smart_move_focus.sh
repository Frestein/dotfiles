#!/usr/bin/env sh

DIRECTION="$1"

case "$DIRECTION" in l | r | u | d) ;;
*)
    echo "Usage: $0 {l|r|u|d}" >&2
    exit 1
    ;;
esac

LAYOUT_CURRENT=$(hyprctl activeworkspace | grep 'tiledLayout:' | awk '{print $2}')

if [ "$LAYOUT_CURRENT" = "monocle" ]; then
    case "$DIRECTION" in
    r | d) hyprctl dispatch 'hl.dsp.layout("cyclenext")' ;;
    l | u) hyprctl dispatch 'hl.dsp.layout("cycleprev")' ;;
    esac
else
    if hyprctl activewindow | grep -q "fullscreen: 2"; then
        case "$DIRECTION" in
        r | d) hyprctl dispatch 'hl.dsp.window.cycle_next()' ;;
        l | u) hyprctl dispatch 'hl.dsp.window.cycle_next({ next = false })' ;;
        esac
    else
        hyprctl dispatch 'hl.dsp.focus({ direction = "'$DIRECTION'" })'
    fi
fi

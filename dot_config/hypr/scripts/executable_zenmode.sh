#!/usr/bin/env dash

HYPRZENMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

if [ "$HYPRZENMODE" = 1 ]; then
    pkill -SIGUSR1 waybar
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 2;\
        keyword decoration:rounding 0"
    makoctl mode -a do-not-disturb
    exit
fi

pkill -SIGUSR1 waybar
hyprctl reload
makoctl mode -r do-not-disturb

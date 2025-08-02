#!/usr/bin/env dash

hyprctl dispatch dpms on

sleep 2

ddcutil setvcp 12 79

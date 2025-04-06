#!/usr/bin/env dash

config="$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
gnome_schema="org.gnome.desktop.interface"

[ ! -f "$config" ] && exit 1

command -v gsettings >/dev/null 2>&1 || exit 1

get_key() {
    key="$1"
    sed -n "s/^[[:space:]]*${key}[[:space:]]*=[[:space:]]*['\"]*\([^'\"]*\)['\"]*/\1/p" "$config" | head -n1
}

font_name=$(get_key "gtk-font-name")
icon_theme=$(get_key "gtk-icon-theme-name")

[ "$icon_theme" != "" ] && gsettings set "$gnome_schema" icon-theme "$icon_theme"
[ "$font_name" != "" ] && gsettings set "$gnome_schema" font-name "$font_name"

# Remove window buttons
gsettings set org.gnome.desktop.wm.preferences button-layout ""

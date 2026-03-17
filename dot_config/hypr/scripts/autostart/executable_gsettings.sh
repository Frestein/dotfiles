#!/usr/bin/env sh

GTK_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
GNOME_SCHEMA="org.gnome.desktop.interface"

[ ! -f "$GTK_CONFIG" ] && exit 1

command -v gsettings >/dev/null 2>&1 || exit 1

get_key() {
    key="$1"
    sed -n "s/^[[:space:]]*${key}[[:space:]]*=[[:space:]]*['\"]*\([^'\"]*\)['\"]*/\1/p" "$GTK_CONFIG" | head -n1
}

GTK_FONT_NAME=$(get_key "gtk-font-name")
GTK_ICON_THEME=$(get_key "gtk-icon-theme-name")

[ "$GTK_ICON_THEME" != "" ] && gsettings set "$GNOME_SCHEMA" icon-theme "$GTK_ICON_THEME"
[ "$GTK_FONT_NAME" != "" ] && gsettings set "$GNOME_SCHEMA" font-name "$GTK_FONT_NAME"

# Remove window buttons
gsettings set org.gnome.desktop.wm.preferences button-layout ""

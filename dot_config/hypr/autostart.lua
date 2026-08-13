hl.on("hyprland.start", function()
	local config_home = os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"
	hl.exec_cmd(config_home .. "/hypr/scripts/autostart/xdg_desktop_portal.sh")
	hl.exec_cmd(config_home .. "/hypr/scripts/autostart/gsettings.sh")
	hl.exec_cmd(
		"uwsm finalize FINALIZED=1 WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS XDG_SESSION_TYPE XDG_CURRENT_DESKTOP"
	)
end)

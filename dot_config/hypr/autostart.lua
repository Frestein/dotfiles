local paths = require("lib.paths")

hl.on("hyprland.start", function()
	hl.exec_cmd(paths.scripts_path .. "/autostart/xdg_desktop_portal.sh")
	hl.exec_cmd(paths.scripts_path .. "/autostart/gsettings.sh")
	hl.exec_cmd(
		"uwsm finalize FINALIZED=1 WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS XDG_SESSION_TYPE XDG_CURRENT_DESKTOP"
	)
end)

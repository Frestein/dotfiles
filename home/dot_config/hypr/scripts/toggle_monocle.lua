-- Toggle the monocle layout on the active workspace.

local WAYBAR_SIGNAL = "pkill -SIGRTMIN+10 waybar"

local function toggle_monocle()
	local ws = hl.get_active_workspace()
	if not ws or not ws.id then
		return
	end

	local layout = ws.tiled_layout == "monocle" and "dwindle" or "monocle"

	hl.workspace_rule { workspace = tostring(ws.id), layout = layout }

	hl.exec_cmd(WAYBAR_SIGNAL)
end

return toggle_monocle

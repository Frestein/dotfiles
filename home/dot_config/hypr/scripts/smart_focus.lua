-- Focus in a direction, falling back to cycling where directional focus
-- makes no sense.

-- Cycle the tile direction r/d forward, l/u backward
---@param direction string # l, r, u or d
local function cycle(direction)
	if direction == "l" or direction == "u" then
		hl.dispatch(hl.dsp.layout "cycleprev")
	else
		hl.dispatch(hl.dsp.layout "cyclenext")
	end
end

---@param direction string # l, r, u or d
local function smart_focus(direction)
	local ws = hl.get_active_workspace()
	if ws and ws.tiled_layout == "monocle" then
		cycle(direction)
		return
	end

	local window = hl.get_window "active"
	if window and window.fullscreen == 2 then
		if direction == "l" or direction == "u" then
			hl.dispatch(hl.dsp.window.cycle_next { next = false })
		else
			hl.dispatch(hl.dsp.window.cycle_next())
		end
		return
	end

	hl.dispatch(hl.dsp.focus { direction = direction })
end

return smart_focus

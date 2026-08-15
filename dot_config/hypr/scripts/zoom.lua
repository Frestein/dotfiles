local MIN_ZOOM = 1
local MAX_ZOOM = 3

---@param param number|nil
---@return nil
local function zoom(param)
	local current = hl.get_config("cursor.zoom_factor") or 1.0

	if param == nil or param == 0 then
		-- Reset to minimum zoom
		current = MIN_ZOOM
	elseif math.abs(param) >= 1 then
		-- Set absolute value (1, 2, 3)
		current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, param))
	else
		-- Adjust by offset (0.5, -0.5)
		current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current + param))
	end

	hl.config({ cursor = { zoom_factor = current } })
end

return zoom

-- Close the active window on a double press: one press alone does nothing,
-- so closing needs a confirmation and never loses a window to misfires.

local CONFIRM_TIMEOUT_MS = 300

local pending = false

local function kill_active()
	if pending then
		pending = false
		hl.dispatch(hl.dsp.window.close { window = "active" })
	else
		pending = true
		hl.timer(function()
			pending = false
		end, { timeout = CONFIRM_TIMEOUT_MS, type = "oneshot" })
	end
end

return kill_active

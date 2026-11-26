--- @since 26.9.1
local get_cwd = ya.sync(function()
	return tostring(cx.active.current.cwd.path)
end)

local function entry()
	local dir = get_cwd()

	local output = Command("git"):arg("rev-parse"):arg("--is-inside-work-tree"):cwd(dir):output()
	if not output or not output.status.success then
		ya.notify({
			title = "Magit",
			content = "Not in a git repository: " .. dir,
			level = "warn",
			timeout = 5,
		})
		return
	end

	local escaped = dir:gsub("\\", "\\\\"):gsub('"', '\\"')
	local elisp = string.format('(fr/magit-dedicated "%s")', escaped)
	local params = ya.quote("((magit-dedicated . t))")
	local cmd = "emacsclient -nw --alternate-editor= --frame-parameters=" .. params .. " -e " .. ya.quote(elisp)
	ya.emit("shell", { cmd, block = true })
end

return { entry = entry }

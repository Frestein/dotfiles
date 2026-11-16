-- delete-current-file.lua (Linux only)
-- Move current file to trash.
-- Not bound by default. To enable, add to input.conf:
--   Del script-binding delete-current-file

local utils = require("mp.utils")

local function run(args)
	local res = utils.subprocess({ args = args, playback_only = false })
	return res.status == 0
end

local function move_to_trash(path)
	local commands = {
		{ "gio", "trash", path },
		{ "trash-put", path },
	}
	for _, args in ipairs(commands) do
		if run(args) then
			return true
		end
	end
	return false
end

local function delete_current_file()
	local path = mp.get_property("path")
	local pos = mp.get_property_number("playlist-pos")
	local count = mp.get_property_number("playlist-count")

	if not path then
		mp.osd_message("No file is playing")
		return
	end

	if move_to_trash(path) then
		mp.osd_message("Moved to trash: " .. path)

		if count > 1 then
			local new_pos = (pos == count - 1) and (pos - 1) or (pos + 1)
			mp.set_property_number("playlist-pos", new_pos)
		end

		mp.commandv("playlist-remove", tostring(pos))
	else
		mp.osd_message("Failed to move file to trash: " .. path)
	end
end

mp.add_key_binding(nil, "delete-current-file", delete_current_file)

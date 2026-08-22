local count = ya.sync(function()
	return #cx.tabs
end)

local function entry()
	if count() < 2 then
		return ya.emit("quit", {})
	end

	local yes = ya.confirm {
		pos = { "center", w = 60, h = 10 },
		title = "Quit?",
		body = ui.Text("There are multiple tabs open.\nAre you sure you want to quit?"):wrap(ui.Wrap.YES):fg "white",
	}

	if yes then
		ya.emit("quit", {})
	end
end

return { entry = entry }

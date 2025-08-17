local key_mapping = {
	q = "й",
	w = "ц",
	e = "у",
	r = "к",
	t = "е",
	y = "н",
	u = "г",
	i = "ш",
	o = "щ",
	p = "з",
	a = "ф",
	s = "ы",
	d = "в",
	f = "а",
	g = "п",
	h = "р",
	j = "о",
	k = "л",
	l = "д",
	z = "я",
	x = "ч",
	c = "с",
	v = "м",
	b = "и",
	n = "т",
	m = "ь",
	Q = "Й",
	W = "Ц",
	E = "У",
	R = "К",
	T = "Е",
	Y = "Н",
	U = "Г",
	I = "Ш",
	O = "Щ",
	P = "З",
	A = "Ф",
	S = "Ы",
	D = "В",
	F = "А",
	G = "П",
	H = "Р",
	J = "О",
	K = "Л",
	L = "Д",
	Z = "Я",
	X = "Ч",
	C = "С",
	V = "М",
	B = "И",
	N = "Т",
	M = "Ь",
	[","] = "б",
	["."] = "ю",
	["`"] = "ё",
	["["] = "х",
	["]"] = "ъ",
}

local function split(inputstr, sep)
	local result = {}

	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(result, str)
	end

	return result
end

local repeatable_commands = {
	"sub-seek",
	"seek",
	"playlist-next",
	"playlist-prev",
	"add",
	"loadfile",
}
local function guess_repeatable_command(cmd)
	for _, rc in ipairs(repeatable_commands) do
		if string.find(cmd, rc, 1, true) then
			return true
		end
	end

	if string.find(cmd, "repeatable", 1, true) then
		return true
	end

	return false
end

local function translate_keybinding(key)
	local parts = split(key, "+")
	local translated_parts = {}
	local changed = false

	for _, part in ipairs(parts) do
		local mapped = key_mapping[part]
		if mapped then
			table.insert(translated_parts, mapped)
			changed = true
		else
			table.insert(translated_parts, part)
		end
	end

	if changed then
		return table.concat(translated_parts, "+")
	else
		return nil
	end
end

mp.add_timeout(1, function()
	local bindings = mp.get_property_native("input-bindings")

	if not bindings then
		mp.msg.warn("Failed to get input-bindings")
		return
	end

	for _, binding in ipairs(bindings) do
		if binding.key then
			local translated_key = translate_keybinding(binding.key)

			if translated_key then
				local name = binding.name or ("translated_" .. translated_key)

				mp.add_key_binding(translated_key, name, function()
					mp.command(binding.cmd)
				end, {
					repeatable = guess_repeatable_command(binding.cmd),
				})
			end
		end
	end
end)

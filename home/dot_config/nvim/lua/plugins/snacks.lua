local dashboard = require "modules.dashboard"

local function merge_keys(default_keys, user_keys)
	local map = {}

	for _, k in ipairs(default_keys or {}) do
		map[k.key] = k
	end

	for _, uk in ipairs(user_keys) do
		map[uk.key] = uk
	end

	local merged = {}
	for _, v in pairs(map) do
		table.insert(merged, v)
	end

	return merged
end

local function order_keys(merged_keys, order)
	local order_map = {}

	for i, key in ipairs(order) do
		order_map[key] = i
	end

	table.sort(merged_keys, function(a, b)
		local ia = order_map[a.key] or (#order + 1)
		local ib = order_map[b.key] or (#order + 1)
		return ia < ib
	end)

	return merged_keys
end

return {
	"folke/snacks.nvim",
	optional = true,
	opts = function(_, opts)
		local keys = dashboard.keys

		local merged = merge_keys(opts.dashboard and opts.dashboard.preset and opts.dashboard.preset.keys or {}, keys)
		local desired_order = { "s", "p", "n", "f", "g", "r", "z", "S", "c", "b", "x", "l", "q" }

		opts.dashboard = opts.dashboard or {}
		opts.dashboard.preset = opts.dashboard.preset or {}
		opts.dashboard.preset.keys = order_keys(merged, desired_order)

		opts.dashboard.sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			{ dashboard.startup },
		}

		return opts
	end,
}

local dashboard = require "modules.dashboard"

return {
	{
		"snacks.nvim",
		opts = {
			indent = {
				animate = {
					enabled = false,
				},
			},
			statuscolumn = {
				folds = {
					open = true,
					git_hl = true,
				},
			},
		},
	},

	{
		"folke/snacks.nvim",
		optional = true,
		---@type snacks.Config
		opts = {
			dashboard = {
				preset = {
					keys = dashboard.keys,
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ dashboard.startup },
				},
			},
		},
	},
}

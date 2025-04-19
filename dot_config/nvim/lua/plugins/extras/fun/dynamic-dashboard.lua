local dashboard = require "modules.dashboard"

return {
	"folke/snacks.nvim",
	optional = true,
	---@type snacks.Config
	opts = {
		dashboard = {
			preset = {
				header = dashboard.get_header(),
			},
		},
	},
}

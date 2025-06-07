return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "toml",
		}
	end,

	"stevearc/conform.nvim",
	optional = true,
	cmd = "ConformInfo",
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			toml = { "taplo" },
		},
	},
}

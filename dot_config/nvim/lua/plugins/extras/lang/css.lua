return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = { "css", "scss", "less" },
		}
	end,

	"neovim/nvim-lspconfig",
	optional = true,
	---@class PluginLspOpts
	opts = {
		---@type lspconfig.options
		servers = {
			cssls = {},
		},
	},
}

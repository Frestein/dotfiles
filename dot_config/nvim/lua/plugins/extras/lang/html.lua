return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "html",
		}
	end,

	"neovim/nvim-lspconfig",
	optional = true,
	---@class PluginLspOpts
	opts = {
		---@type lspconfig.options
		servers = {
			html = {},
		},
	},
}

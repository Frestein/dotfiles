return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "systemd",
		}
	end,

	{
		"neovim/nvim-lspconfig",
		optional = true,
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				systemd_ls = {},
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				systemd = { "systemd-analyze" },
			},
		},
	},
}

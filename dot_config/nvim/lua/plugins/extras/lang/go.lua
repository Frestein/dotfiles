return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = { "go", "gomod", "gowork", "gotmpl" },
			root = { "go.work", "go.mod" },
		}
	end,

	{

		"ray-x/go.nvim",
		ft = { "go", "gomod" },
		config = function(_, opts)
			require("go").setup(opts)
		end,
	},

	{

		"neovim/nvim-lspconfig",
		optional = true,
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				golangci_lint_ls = {},
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				go = { "golangcilint" },
				gomod = { "golangcilint" },
			},
		},
	},
}

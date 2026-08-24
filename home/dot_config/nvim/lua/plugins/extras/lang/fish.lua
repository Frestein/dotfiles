return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "fish",
		}
	end,

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = function()
			vim.lsp.enable "fish_lsp"
		end,
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				fish = { "fish" },
			},
		},
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		cmd = "ConformInfo",
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				fish = { "fish_indent" },
			},
		},
	},
}

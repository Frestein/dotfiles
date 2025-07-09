local lsp = vim.g.lazyvim_toml_lsp or "taplo"

return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "toml",
			root = "*.toml",
		}
	end,

	{
		"neovim/nvim-lspconfig",
		optional = true,
		setup = function()
			vim.lsp.enable(lsp)
		end,
	},

	{

		"stevearc/conform.nvim",
		optional = true,
		cmd = "ConformInfo",
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				toml = { lsp },
			},
		},
	},
}

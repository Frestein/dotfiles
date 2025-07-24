return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "systemd",
		}
	end,

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = function()
			vim.lsp.enable "systemd_ls"
		end,
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

return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = { "qml", "qmljs", "qmldir" },
		}
	end,

	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "qmljs", "qmldir" } },
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = function()
			vim.lsp.enable "qmlls"
		end,
	},
}

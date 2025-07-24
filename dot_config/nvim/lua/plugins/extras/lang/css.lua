return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = { "css", "scss", "less" },
		}
	end,

	"neovim/nvim-lspconfig",
	optional = true,
	opts = function()
		vim.lsp.enable "cssls"
	end,
}

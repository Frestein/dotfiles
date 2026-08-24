local lsp = vim.g.lazyvim_html_lsp or "html"

return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "html",
		}
	end,

	"neovim/nvim-lspconfig",
	optional = true,
	opts = function()
		vim.lsp.enable(lsp)
	end,
}

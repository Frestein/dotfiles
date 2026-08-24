return {
	"neovim/nvim-lspconfig",
	optional = true,
	event = vim.fn.has "nvim-0.11" == 1 and { "BufReadPre", "BufNewFile", "BufWritePre" } or "LazyFile",
	---@class PluginLspOpts
	opts = {
		---@type vim.diagnostic.Opts
		diagnostics = {
			virtual_text = { prefix = "" },
		},
	},
}

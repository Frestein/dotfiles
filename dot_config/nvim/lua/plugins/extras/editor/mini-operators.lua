return {
	{
		"echasnovski/mini.operators",
		event = "VeryLazy",
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
        -- stylua: ignore
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()

			keys[#keys + 1] = { "gr", false }
			keys[#keys + 1] = { "gR", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" }
		end,
	},
}

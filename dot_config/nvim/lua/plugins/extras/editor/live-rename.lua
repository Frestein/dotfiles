return {
	{
		"saecki/live-rename.nvim",
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
        -- stylua: ignore
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			keys[#keys + 1] = { "<leader>cr", function() require("live-rename").rename { insert = true } end, desc = "Rename", }
		end,
	},
}

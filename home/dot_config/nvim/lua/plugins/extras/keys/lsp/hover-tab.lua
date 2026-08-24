return {
	"neovim/nvim-lspconfig",
	optional = true,
        -- stylua: ignore
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			keys[#keys + 1] = { "K", false }
			keys[#keys + 1] = { "<Tab>", function() vim.lsp.buf.hover() end, desc = "Hover", }
		end,
}

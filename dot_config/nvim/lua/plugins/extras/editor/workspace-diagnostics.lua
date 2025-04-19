return {
	{
		"artemave/workspace-diagnostics.nvim",
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
        -- stylua: ignore
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()

			keys[#keys + 1] = {
				"<leader>cwp",
				function()
					for _, client in ipairs(vim.lsp.get_clients()) do
						require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
					end
				end,
				desc = "Populate Diagnostics (LSP)",
			}
		end,
	},
}

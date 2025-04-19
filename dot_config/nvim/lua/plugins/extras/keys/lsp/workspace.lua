return {
	{
		"neovim/nvim-lspconfig",
		optional = true,
        -- stylua: ignore
		opts = function()
			local lsp = vim.lsp.buf
			local keys = require("lazyvim.plugins.lsp.keymaps").get()

			keys[#keys + 1] = { "<leader>cwa", function() lsp.add_workspace_folder() end, desc = "Add Folder (LSP)" }
			keys[#keys + 1] = { "<leader>cwr", function() lsp.remove_workspace_folder() end, desc = "Remove Folder (LSP)" }
			keys[#keys + 1] = { "<leader>cwl", function() print(vim.inspect(lsp.list_workspace_folders())) end, desc = "List Folders (LSP)" }
		end,
	},

	{
		"folke/which-key.nvim",
		optional = true,
		opts = function(_, opts)
			table.insert(opts.spec, { "<leader>cw", group = "workspace" })
		end,
	},
}

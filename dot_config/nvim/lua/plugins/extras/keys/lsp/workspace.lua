return {
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				["*"] = {
                    -- stylua: ignore
					keys = {
						{ "<leader>cwa", function() vim.lsp.buf.add_workspace_folder() end, desc = "Add Folder (LSP)" },
						{ "<leader>cwr", function() vim.lsp.buf.remove_workspace_folder() end, desc = "Remove Folder (LSP)" },
						{ "<leader>cwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List Folders (LSP)" },
					},
				},
			},
		},
	},

	{
		"folke/which-key.nvim",
		optional = true,
		opts = function(_, opts)
			table.insert(opts.spec, { "<leader>cw", group = "workspace" })
		end,
	},
}

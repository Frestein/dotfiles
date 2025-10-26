return {
	{
		"nvim-mini/mini.operators",
		event = "VeryLazy",
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				["*"] = {
                    -- stylua: ignore
					keys = {
						{ "gr", false },
						{ "gR", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
					},
				},
			},
		},
	},
}

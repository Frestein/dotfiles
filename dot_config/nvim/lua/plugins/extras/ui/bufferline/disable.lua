vim.o.showtabline = 0

return {
	{ "akinsho/bufferline.nvim", enabled = false, optional = true },

	{
		"nvim-lualine/lualine.nvim",
		optional = true,
		opts = {
			sections = {
				lualine_z = {
					"tabs",
				},
			},
		},
	},
}

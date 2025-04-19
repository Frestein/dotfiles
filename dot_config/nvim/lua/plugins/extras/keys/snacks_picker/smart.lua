return {
	{
		"folke/snacks.nvim",
		optional = true,
		-- stylua: ignore
		keys = {
			{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Find Files (smart)" },
		},
	},
}

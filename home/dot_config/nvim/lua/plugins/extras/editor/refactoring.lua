return {
	{
		"ThePrimeagen/refactoring.nvim",
		optional = true,
        -- stylua: ignore
		keys = {
			{
				"<leader>rI",
				function() require("refactoring").refactor "Inline Function" end,
				desc = "Inline Function",
			},
		},
	},
}

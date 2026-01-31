return {
	"m4xshen/hardtime.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	opts = {
		restricted_keys = {
			["j"] = { "x" },
			["k"] = { "x" },
			["h"] = { "x" },
			["l"] = { "x" },
		},
	},
}

return {
	"Wansmer/sibling-swap.nvim",
	dependencies = "nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	opts = {
		keymaps = {
			["gs."] = "swap_with_right",
			["gs,"] = "swap_with_left",
			["gS."] = "swap_with_right_with_opp",
			["gS,"] = "swap_with_left_with_opp",
		},
	},
}

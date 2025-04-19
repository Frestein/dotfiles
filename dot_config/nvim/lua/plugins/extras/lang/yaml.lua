return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "yaml",
		}
	end,

	"mfussenegger/nvim-lint",
	optional = true,
	opts = {
		linters_by_ft = {
			yaml = { "yamllint" },
		},
	},
}

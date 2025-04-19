return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = { "markdown", "markdown.mdx" },
			root = "README.md",
		}
	end,

	"mfussenegger/nvim-lint",
	optional = true,
	opts = {
		linters_by_ft = {
			markdown = { "markdownlint-cli2" },
		},
	},
}

return {
	"nvim-treesitter/nvim-treesitter",
	optional = true,
	recommended = true,
	desc = "Language support for dotfiles",
	opts = function(_, opts)
		vim.filetype.add {
			pattern = {
				[".*/.*%.hl"] = "hyprlang",
				[".*/.chezmoiignore"] = "gitignore",
			},
		}
	end,
}

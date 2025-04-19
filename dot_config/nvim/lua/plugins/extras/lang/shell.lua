return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = { "sh", "bash", "dash", "fish", "zsh" },
		}
	end,

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				bash = { "shellcheck", "bash" },
				dash = { "shellcheck", "dash" },
				fish = { "fish" },
				sh = { "shellcheck", "bash" },
				zsh = { "zsh" },
			},
		},
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		cmd = "ConformInfo",
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				bash = { "shellharden", "shellcheck", "shfmt" },
				dash = { "shfmt" },
				fish = { "fish_indent" },
				sh = { "shellharden", "shellcheck", "shfmt" },
				zsh = { "shfmt" },
			},
		},
	},
}

local fs = require "utils.fs"

return {
	"nvim-treesitter/nvim-treesitter",
	optional = true,
	recommended = true,
	desc = "Language support for dotfiles",
	opts = function(_, opts)
		local function add(lang)
			if type(opts.ensure_installed) == "table" then
				table.insert(opts.ensure_installed, lang)
			end
		end

		vim.filetype.add {
			pattern = {
				[".*/.*%.hl"] = "hyprlang",
				[".*/ghostty/config"] = "bash",
				[".*/.chezmoiignore"] = "gitignore",
			},
		}
	end,
}

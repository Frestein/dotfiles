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
				[".*/kanata/.+"] = "kanata",
				[".*/newsboat/.+"] = "config",
				[".*/zathura/themes/.+"] = "zathurarc",
				[".*/.chezmoiignore"] = "gitignore",
			},
		}

		if fs.exists "zathura" then
			add "zathurarc"
		end

		if fs.exists ".Xresources" then
			add "xresources"
		end

		if fs.exists "kanata" then
			vim.api.nvim_create_autocmd("User", {
				pattern = "TSUpdate",
				callback = function()
					require("nvim-treesitter.parsers").kanata = {
						install_info = {
							url = "https://github.com/Frestein/tree-sitter-kanata",
							revision = "HEAD",
							queries = "queries",
						},
						tier = 4,
					}
				end,
			})

			add "kanata"
		end
	end,
}

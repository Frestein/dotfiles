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
			},
		}

		if fs.exists "zathura" then
			add "zathurarc"
		end

		if fs.exists ".Xresources" then
			add "xresources"
		end

		if fs.exists "kanata" then
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

			parser_config.kanata = {
				install_info = {
					url = "~/Projects/git/tree-sitter-kanata/",
					files = { "src/parser.c" },
					generate_requires_npm = true,
					requires_generate_from_grammar = true,
				},
				filetype = "kanata",
			}

			add "kanata"
		end
	end,
}

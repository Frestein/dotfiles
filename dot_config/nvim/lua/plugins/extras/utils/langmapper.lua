return {
	recommended = true,
	desc = "A plugin that makes Neovim more friendly to non-English input methods",
	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1,
		opts = {
			default_layout = [[ABCDEFGHIJKLMNOPQRSTUVWXYZ<>:"{}~abcdefghijklmnopqrstuvwxyz,.;'[]`]],
			layouts = {
				ru = {
					id = "ru",
					layout = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯБЮЖЭХЪËфисвуапршолдьтщзйкыегмцчнябюжэхъё",
				},
			},
		},
		config = function(_, opts)
			local lm = require "langmapper"

			lm.setup(opts)
			lm.hack_get_keymap()

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyDone",
				once = true,
				callback = function()
					lm.automapping { global = true, buffer = false }
				end,
			})
		end,
	},

	{
		"folke/which-key.nvim",
		optional = true,
		opts = function()
			local lmu = require "langmapper.utils"
			local wk_state = require "which-key.state"
			local check_orig = wk_state.check

			---@diagnostic disable-next-line: duplicate-set-field
			wk_state.check = function(state, key)
				if key ~= nil then
					key = lmu.translate_keycode(key, "default", "ru")
				end

				return check_orig(state, key)
			end
		end,
	},

	{
		"folke/snacks.nvim",
		optional = true,
		opts = function()
			local lmu = require "langmapper.utils"
			local sn_util = Snacks.util
			local normkey_orig = sn_util.normkey

			sn_util.normkey = function(key)
				if key then
					key = lmu.translate_keycode(key, "default", "ru")
				end

				return normkey_orig(key)
			end
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		config = function(_, opts)
			local flash = require "flash"
			local langmapper = require "langmapper"

			for _, mode in pairs { "n", "x", "o" } do
				langmapper.original_set_keymap(mode, "s", "", {
					nowait = true,
					desc = "Flash",
					callback = function()
						flash.jump()
					end,
				})
				langmapper.original_set_keymap(mode, "ы", "", {
					nowait = true,
					desc = "Flash",
					callback = function()
						flash.jump {
							labels = "олджавыфгнрткепимйцуячсшщзьбюАВЫФОЛДЖЙЦУКЕНГШЩЗ",
						}
					end,
				})
			end

			flash.setup(opts)
		end,
	},
}

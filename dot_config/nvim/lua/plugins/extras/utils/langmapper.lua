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
}

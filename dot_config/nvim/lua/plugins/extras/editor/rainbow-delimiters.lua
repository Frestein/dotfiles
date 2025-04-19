return {
	{
		"hiphish/rainbow-delimiters.nvim",
		event = "VeryLazy",
		opts = function()
			local rainbow_delimiters = require "rainbow-delimiters"
			return {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
				},
				query = {
					[""] = "rainbow-delimiters",
				},
			}
		end,
		config = function(_, opts)
			require("rainbow-delimiters.setup").setup(opts)

			local rainbow_delimiters = require "rainbow-delimiters"
			Snacks.toggle({
				name = "Rainbow Delimiters",
				get = function()
					return rainbow_delimiters.is_enabled(0)
				end,
				set = function(state)
					if state then
						rainbow_delimiters.enable(0)
					else
						rainbow_delimiters.disable(0)
					end
				end,
			}):map "<leader>uR"
		end,
	},
}

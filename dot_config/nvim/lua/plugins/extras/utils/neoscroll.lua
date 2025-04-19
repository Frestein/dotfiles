return {
	{
		"folke/snacks.nvim",
		opts = {
			scroll = { enabled = false },
		},
	},

	{
		"karb94/neoscroll.nvim",
		opts = {
			easing = "quadratic",
			pre_hook = function(info)
				if info == "cursorline" then
					vim.wo.cursorline = false
				end
			end,
			post_hook = function(info)
				if info == "cursorline" then
					vim.wo.cursorline = true
				end
			end,
		},
		keys = function()
			local mode = { "n", "v" }

			return {
				{
					mode = mode,
					"<C-u>",
					function()
						require("neoscroll").ctrl_u { duration = 320, easing = "sine" }
					end,
				},
				{
					mode = mode,
					"<C-d>",
					function()
						require("neoscroll").ctrl_d { duration = 320, easing = "sine" }
					end,
				},
				{
					mode = mode,
					"<C-b>",
					function()
						require("neoscroll").ctrl_b { duration = 420, easing = "circular", info = "cursorline" }
					end,
				},
				{
					mode = mode,
					"<C-f>",
					function()
						require("neoscroll").ctrl_f { duration = 420, easing = "circular", info = "cursorline" }
					end,
				},
				{
					mode = mode,
					"<C-y>",
					function()
						require("neoscroll").scroll(
							-0.1,
							{ move_cursor = false, duration = 100, easing = "linear", info = "cursorline" }
						)
					end,
				},
				{
					mode = mode,
					"<C-e>",
					function()
						require("neoscroll").scroll(
							0.1,
							{ move_cursor = false, duration = 100, easing = "linear", info = "cursorline" }
						)
					end,
				},
				{
					mode = mode,
					"zt",
					function()
						require("neoscroll").zt { half_win_duration = 250 }
					end,
				},
				{
					mode = mode,
					"zz",
					function()
						require("neoscroll").zz { half_win_duration = 250 }
					end,
				},
				{
					mode = mode,
					"zb",
					function()
						require("neoscroll").zb { half_win_duration = 250 }
					end,
				},
			}
		end,
	},
}

local opts = {
	themes = {
		{ theme = "new_year", month = 1, day = 1 },
		{ theme = "valentines_day", month = 2, day = 14 },
		{ theme = "winter_wonderland", month = 2, day = 22 },
		{ theme = "stars", month = 2, day = 29 },
		{ theme = "easter", holiday = "easter" },
		{ theme = "april_fools", month = 4, day = 1 },
		{ theme = "art", month = 9, day = 1 },
		{ theme = "binary", month = 9, day = 13 },
		{ theme = "halloween", month = 10, day = 31 },
		{ theme = "xmas", from = { month = 12, day = 28 }, to = { month = 1, day = 14 } },
		{ theme = "leaves", from = { month = 9, day = 1 }, to = { month = 11, day = 30 } },
		{ theme = "snow", from = { month = 12, day = 1 }, to = { month = 2, day = 28 } },
		{ theme = "spring", from = { month = 3, day = 1 }, to = { month = 5, day = 31 } },
		{ theme = "summer", from = { month = 6, day = 1 }, to = { month = 8, day = 31 } },
	},
	max = 75,
	interval = 150,
	winblend = 50,
	filetypes = {},
}

local win_width = vim.api.nvim_win_get_width(0)
local win_height = vim.api.nvim_win_get_height(0)

if win_width < 150 and win_height < 50 then
	opts.max = 25
elseif win_width < 150 then
	opts.max = 50
else
	opts.max = 75
end

return {
	"folke/drop.nvim",
	event = "VimEnter",
	opts = opts,
}

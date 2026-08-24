_G.__last_insert_range = {}
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function(e)
		local cur = vim.api.nvim_win_get_cursor(0)
		_G.__last_insert_range = { cur[1] - 1, cur[2], cur[1] - 1, cur[2] }
	end,
})

vim.api.nvim_create_autocmd({ "TextChangedI" }, {
	callback = function(e)
		local cur = vim.api.nvim_win_get_cursor(0)
		-- Update range on new line
		if _G.__last_insert_range[1] ~= cur[1] - 1 then
			_G.__last_insert_range[1] = cur[1] - 1
			_G.__last_insert_range[2] = cur[2]
			_G.__last_insert_range[3] = cur[1] - 1
		end

		_G.__last_insert_range[4] = cur[2]
	end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "WinLeave" }, {
	callback = function(e)
		_G.__last_insert_range = {}
	end,
})

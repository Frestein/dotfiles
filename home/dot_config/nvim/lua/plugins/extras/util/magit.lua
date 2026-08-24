local function open_magit()
	local cmd = 'emacsclient -nw -e "(call-interactively \'magit-status)"'
	Snacks.terminal.open(cmd, {
		cwd = vim.fn.getcwd(),
		win = { style = "float", size = { 0.85, 0.85 }, border = "rounded" },
	})
end

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimKeymaps",
	once = true,
	callback = function()
		vim.keymap.set("n", "<leader>gg", open_magit, { desc = "Magit" })
	end,
})

return {}

local function open_magit()
	local cwd = vim.fn.getcwd()
	local output = vim.fn.system({ "git", "-C", cwd, "rev-parse", "--is-inside-work-tree" })
	if vim.v.shell_error ~= 0 or vim.trim(output) ~= "true" then
		Snacks.notify.warn("Not in a git repository: " .. cwd, { title = "Magit" })
		return
	end

	local escaped = cwd:gsub("\\", "\\\\"):gsub('"', '\\"')
	local elisp = string.format('(fr/magit-dedicated "%s")', escaped)

	Snacks.terminal.open({
		"emacsclient",
		"-nw",
		"--alternate-editor=",
		"--frame-parameters=((magit-dedicated . t))",
		"-e",
		elisp,
	}, {
		cwd = cwd,
		auto_close = true,
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

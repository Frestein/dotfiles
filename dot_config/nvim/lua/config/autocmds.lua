local autocmd = vim.api.nvim_create_autocmd
local bo = vim.bo
local wo = vim.wo
local o = vim.o

local function augroup(name)
	return vim.api.nvim_create_augroup("nvchan_" .. name, { clear = true })
end

autocmd("FileType", {
	pattern = { "norg", "markdown" },
	group = augroup "docs_folds",
	callback = function()
		wo.foldlevel = 99
		wo.conceallevel = 2
	end,
})

-- Restore cursor position
autocmd("BufReadPost", {
	pattern = "*",
	group = augroup "restore_cursor",
	callback = function()
		local line = vim.fn.line "'\""
		if
			line > 1
			and line <= vim.fn.line "$"
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd 'normal! g`"'
		end
	end,
})

-- Securing editor
autocmd({ "BufNewFile", "BufRead" }, {
	group = augroup "gopass",
	pattern = "/dev/shm/gopass*",
	callback = function()
		bo.swapfile = false
		bo.undofile = false
		o.backup = false
		o.shada = ""
	end,
})

-- Autogenerate spell files
autocmd("VimEnter", {
	group = augroup "spell",
	callback = function()
		for _, file in ipairs(vim.fn.glob("~/.config/nvim/spell/*.add", true, 1)) do
			local spl_file = file .. ".spl"
			if
				vim.fn.filereadable(file)
				and (not vim.fn.filereadable(spl_file) or vim.fn.getftime(file) > vim.fn.getftime(spl_file))
			then
				vim.cmd("mkspell! " .. vim.fn.fnameescape(file))
			end
		end
	end,
})

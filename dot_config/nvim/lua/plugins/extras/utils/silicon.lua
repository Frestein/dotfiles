return {
	"michaelrommel/nvim-silicon",
	opts = {
		font = "Maple Mono NF=34",
		to_clipboard = true,
		theme = "gruvbox-dark",
		pad_horiz = 40,
		pad_vert = 40,
		background = "#EDDCB1",
		language = function()
			return vim.bo.filetype
		end,
		window_title = function()
			return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
		end,
		output = function()
			local pictures_dir = vim.fn.trim(vim.fn.system "xdg-user-dir PICTURES")

			if pictures_dir == "" or vim.v.shell_error ~= 0 then
				pictures_dir = os.getenv "HOME" .. "/Pictures"
			end

			local screenshots_dir = pictures_dir .. "/Screenshots"
			vim.fn.mkdir(screenshots_dir, "p")

			local filename = os.date "C%H.%M.%S-D%m.%d.%Y" .. ".png"

			return screenshots_dir .. "/" .. filename
		end,
	},
	keys = {
		{
			mode = "v",
			"<leader>ss",
			function()
				require("nvim-silicon").shoot()
			end,
			desc = "Screenshot Code",
		},
		{
			mode = "v",
			"<leader>sf",
			function()
				require("nvim-silicon").file()
			end,
			desc = "Screenshot Code (file)",
		},
		{
			mode = "v",
			"<leader>sc",
			function()
				require("nvim-silicon").clip()
			end,
			desc = "Screenshot Code (clipboard)",
		},
	},
}

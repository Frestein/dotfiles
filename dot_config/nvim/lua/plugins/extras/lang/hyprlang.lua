return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "hyprlang",
			root = {
				"hyprland.conf",
				"hypridle.conf",
				"hyprlock.conf",
				"hyprpaper.conf",
			},
		}
	end,

	"neovim/nvim-lspconfig",
	optional = true,
	opts = function()
		vim.lsp.enable "hyprls"
	end,
}

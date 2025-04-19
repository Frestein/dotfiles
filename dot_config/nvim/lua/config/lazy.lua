local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.o.rtp = lazypath .. "," .. vim.o.rtp

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lazy",
	group = vim.api.nvim_create_augroup("LazyUserGroup", { clear = true }),
	desc = "Quit lazy with <Esc>",
	callback = function()
		vim.keymap.set("n", "<Esc>", function()
			vim.api.nvim_win_close(0, false)
		end, { buffer = true, nowait = true })
	end,
})

require("lazy").setup {
	spec = {
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		{ import = "plugins" },
	},
	defaults = {
		lazy = true,
		version = false,
	},
	install = { colorscheme = { "tokyonight", "habamax" } },
	checker = {
		enabled = true,
		notify = false,
	},
	ui = {
		icons = {
			ft = "",
			cmd = "󰞷",
			lazy = "󰂠 ",
			event = "󰪓 ",
			loaded = "",
			not_loaded = "",
			keys = " ",
			source = "",
			runtime = "󰢱",
			require = "󰌹",
			start = "",
			list = {
				"●",
				"",
				"",
				"",
			},
		},
		custom_keys = {
			["<localleader>y"] = {
				function(plugin)
					require("lazy.util").float_term { "yazi", plugin.dir }
				end,
				desc = "Open yazi in plugin dir",
			},
		},
	},
	dev = {
		---@type string | fun(plugin: LazyPlugin): string directory where you store your local plugin projects
		path = "~/Projects/nvim/plugins/",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		patterns = { "Frestein" },
		fallback = true, -- Fallback to git when local plugin doesn't exist
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"bugreport",
				"compiler",
				"ftplugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"matchit",
				"netrw",
				"netrwFileHandlers",
				"netrwPlugin",
				"netrwSettings",
				"optwin",
				"rplugin",
				"rrhelper",
				"spellfile_plugin",
				"synmenu",
				"syntax",
				"tar",
				"tarPlugin",
				"tohtml",
				"tutor",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
}

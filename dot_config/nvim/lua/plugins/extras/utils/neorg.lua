return {
	{
		"nvim-neorg/neorg",
		version = "*",
		ft = "norg",
		opts = {
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/Documents/notes",
						},
						default_workspace = "notes",
					},
				},
				["core.integrations.telescope"] = {
					config = {
						insert_file_link = {
							show_title_preview = true,
						},
					},
				},
			},
		},
		config = function(_, opts)
			require("neorg").setup(opts)
			local neorg_callbacks = require "neorg.core.callbacks"

			neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
				keybinds.map_event_to_mode("norg", {
					n = {
						{ "<leader>fl", "core.integrations.telescope.find_linkable" },
					},
				}, {
					silent = true,
					noremap = true,
				})
			end)
		end,
	},
}

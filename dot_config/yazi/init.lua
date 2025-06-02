--------------------------------------------------------------------------------
--                               Configurations                               --
--------------------------------------------------------------------------------

-- Borders
require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.PLAIN,
})

-- -- Statusline
-- require("yaziline"):setup({
-- 	-- color = "#A89984",
-- 	secondary_color = "#504945",
--
-- 	select_symbol = "",
-- 	yank_symbol = "󰆐",
-- })

-- Tools
require("git"):setup()
require("bookmarks"):setup({
	persist = "vim",
	desc_format = "parent",
	file_pick_mode = "parent",
})
require("smart-enter"):setup({
	open_multi = true,
})
require("folder-rules"):setup()

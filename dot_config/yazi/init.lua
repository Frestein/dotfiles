--------------------------------------------------------------------------------
--                               Configurations                               --
--------------------------------------------------------------------------------

-- Borders
require("full-border"):setup()

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

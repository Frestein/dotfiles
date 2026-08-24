return {
	"akinsho/bufferline.nvim",
	optional = true,
	keys = {
		{ "<S-h>", false },
		{ "<S-l>", false },
		{ "J", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "K", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{
			"gj",
			function()
				local count = vim.v.count > 0 and vim.v.count or 1
				vim.cmd("join " .. count)
			end,
			desc = "Join",
		},
	},
}

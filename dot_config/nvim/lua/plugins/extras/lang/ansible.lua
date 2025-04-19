return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "yaml.ansible",
			root = { "ansible.cfg", ".ansible-lint" },
		}
	end,

	"mfussenegger/nvim-lint",
	optional = true,
	opts = {
		linters_by_ft = {
			["yaml.ansible"] = { "ansible_lint" },
		},
	},
}

return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = "org",
	opts = {
		org_agenda_files = "~/Documents/org/**/*",
		org_default_notes_file = "~/Documents/org/refile.org",
		org_todo_keywords = { "TODO", "WAIT", "|", "DONE" },
	},
}

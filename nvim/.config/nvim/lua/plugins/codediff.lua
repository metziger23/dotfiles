return {
	"esmuellert/codediff.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	cmd = "CodeDiff",
	opts = {
		-- Keymaps in diff view
		keymaps = {
			view = {
				next_hunk = "]h", -- Jump to next change
				prev_hunk = "[h", -- Jump to previous change
			},
		},
	},
}

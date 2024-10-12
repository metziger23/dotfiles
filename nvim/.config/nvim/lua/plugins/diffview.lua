return {
	"sindrets/diffview.nvim", -- optional - Diff integration
	config = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = {
		"DiffviewClose",
		"DiffviewLog",
		"DiffviewOpen",
		"DiffviewRefresh",
		"DiffviewFocusFiles",
		"DiffviewFileHistory",
		"DiffviewToggleFiles",
	},
}

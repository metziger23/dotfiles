return {
	"sindrets/diffview.nvim", -- optional - Diff integration
	config = true,
	cmd = {
  dependencies = { "nvim-tree/nvim-web-devicons" },
		"DiffviewClose",
		"DiffviewLog",
		"DiffviewOpen",
		"DiffviewRefresh",
		"DiffviewFocusFiles",
		"DiffviewFileHistory",
		"DiffviewToggleFiles",
	},
}

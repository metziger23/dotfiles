return {
	"folke/todo-comments.nvim",
	cmd = { "TodoTrouble", "TodoFzfLua" },
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim",
    { "metziger23/snacks.nvim", branch = "fix-snacks-picker-insert" } },
	opts = {},
	keys = {
		{
			"<BS>T",
			"<Cmd>TodoFzfLua<Cr>",
			desc = "Fzf todo comments",
			mode = { "n", "x" },
		},
	},
}

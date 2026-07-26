return {
	"metziger23/snacks.nvim",
	branch = "fix-snacks-picker-insert",
	opts = {
		words = {},
	},
	keys = {
		{
			"<M-Left>",
			function()
				require("snacks").words.jump(-vim.v.count1, true)
			end,
			desc = "Prev Reference",
		},
		{
			"<M-Right>",
			function()
				require("snacks").words.jump(vim.v.count1, true)
			end,
			desc = "Next Reference",
		},
	},
}

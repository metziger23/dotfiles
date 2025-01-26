return {
	"folke/todo-comments.nvim",
	cmd = { "TodoTrouble" },
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim", },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{ "<BS>t", function() require("snacks").picker.todo_comments() end, desc = "Todo", },
		{ "<BS>T", function()
				require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
			end, desc = "Todo/Fix/Fixme", },
	},
}

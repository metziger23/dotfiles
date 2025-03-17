-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
return {
	"numToStr/Comment.nvim",
	keys = {
		{ "gcc", mode = "n", desc = "Comment toggle current line" },
		{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
		{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
		{ "gbc", mode = "n", desc = "Comment toggle current block" },
		{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
		{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
	},
	config = function(_, opts)
		require("Comment").setup(opts)
	end,
}

return {
	"kwkarlwang/bufjump.nvim",
	config = function()
		require("bufjump").setup({
			forward_key = "<A-i>",
			backward_key = "<A-o>",
		})
	end,
}

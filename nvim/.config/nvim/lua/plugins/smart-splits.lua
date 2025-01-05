return {
	"mrjones2014/smart-splits.nvim",
	version = "*",
	lazy = false,
	config = function()
		require("smart-splits").setup({})

		vim.keymap.set("n", "<C-S-Left>", require("smart-splits").move_cursor_left, { desc = "Move cursor left" })
		vim.keymap.set("n", "<C-S-Down>", require("smart-splits").move_cursor_down, { desc = "Move cursor down" })
		vim.keymap.set("n", "<C-S-Up>", require("smart-splits").move_cursor_up, { desc = "Move cursor up" })
		vim.keymap.set("n", "<C-S-Right>", require("smart-splits").move_cursor_right, { desc = "Move cursor right" })
	end,
}

return {
	"mrjones2014/smart-splits.nvim",
  build = './kitty/install-kittens.bash',
	version = "*",
	lazy = false,
	config = function()
		require("smart-splits").setup({})

		vim.keymap.set("n", "<C-S-Left>", require("smart-splits").move_cursor_left, { desc = "Move cursor left" })
		vim.keymap.set("n", "<C-S-Down>", require("smart-splits").move_cursor_down, { desc = "Move cursor down" })
		vim.keymap.set("n", "<C-S-Up>", require("smart-splits").move_cursor_up, { desc = "Move cursor up" })
		vim.keymap.set("n", "<C-S-Right>", require("smart-splits").move_cursor_right, { desc = "Move cursor right" })

		vim.keymap.set("n", "<M-C-S-Left>", require("smart-splits").resize_left, { desc = "Resize left" })
		vim.keymap.set("n", "<M-C-S-Down>", require("smart-splits").resize_down, { desc = "Resize down" })
		vim.keymap.set("n", "<M-C-S-Up>", require("smart-splits").resize_up, { desc = "Resize up" })
		vim.keymap.set("n", "<M-C-S-Right>", require("smart-splits").resize_right, { desc = "Resize right" })
	end,
}

return {
	"smart-splits-nvim/smart-splits.nvim",
	version = "^3.0.0",
	lazy = false,
	opts = { -- Plugin Configuration
		mux = {
			backend = "smart-splits-backend-kitty",
		},
	},
	dependencies = {
		{
			"smart-splits-nvim/backend-kitty",
			module = "smart-splits-backend-kitty",
			opts = {
				-- Set false to force detect() to fail without uninstalling the plugin.
				enable = true,

				-- Remote-control password. When unset, falls back to
				-- vim.g.smart_splits_kitty_password.
				-- https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.remote_control_password
				password = nil,

				-- Which edges may create a Kitty split when move.at_edge is 'split'.
				split = {
					left = true,
					right = true,
					up = true,
					down = true,
				},

				-- Kitty's stack layout is its zoom/fullscreen.
				zoom = {
					block_nav = false, -- refuse move and resize while the tab layout is 'stack'
				},
			},
		},
	},
	init = function()
		vim.keymap.set("n", "<C-S-Left>", require("smart-splits").move_cursor_left, { desc = "Move cursor left" })
		vim.keymap.set("n", "<C-S-Down>", require("smart-splits").move_cursor_down, { desc = "Move cursor down" })
		vim.keymap.set("n", "<C-S-Up>", require("smart-splits").move_cursor_up, { desc = "Move cursor up" })
		vim.keymap.set("n", "<C-S-Right>", require("smart-splits").move_cursor_right, { desc = "Move cursor right" })

		vim.keymap.set("n", "<M-C-Left>", require("smart-splits").resize_left, { desc = "Resize left" })
		vim.keymap.set("n", "<M-C-Down>", require("smart-splits").resize_down, { desc = "Resize down" })
		vim.keymap.set("n", "<M-C-Up>", require("smart-splits").resize_up, { desc = "Resize up" })
		vim.keymap.set("n", "<M-C-Right>", require("smart-splits").resize_right, { desc = "Resize right" })
	end,
}

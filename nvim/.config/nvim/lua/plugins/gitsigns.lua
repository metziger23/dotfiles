local function on_attach(buffer)
	local gitsigns = require("gitsigns")

	local function map(mode, l, r, desc)
		vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
	end

	-- navigation
	map("n", "]h", function() gitsigns.next_hunk() end, { desc = "Next hunk" })
	map("n", "[h", function() gitsigns.prev_hunk() end, { desc = "Previous hunk" })

	-- actions
	map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
	map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
	map("v", "<leader>hs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Stage hunk (selected)" })
	map("v", "<leader>hr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Reset hunk (selected)" })
	map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
	map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
	map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
	map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
	map("n", "<leader>hb", function()
		gitsigns.blame_line({ full = true })
	end, { desc = "Blame line" })
	map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Git blame line" })
	map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git diff" })
	map("n", "<leader>hD", function()
		gitsigns.diffthis("~")
	end, { desc = "Git diff (HEAD)" })
	map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle Git deleted" })
    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

end

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = on_attach,
	},
}

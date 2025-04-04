local hydra_utils = require("../utils/hydra_utils")

local function on_attach(bufnr)
	local gitsigns = require("gitsigns")

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	-- map("n", "]h", function()
	-- 	if vim.wo.diff then
	-- 		vim.cmd.normal({ "]h", bang = true })
	-- 	else
	-- 		gitsigns.nav_hunk("next")
	-- 	end
	-- end)
	--
	-- map("n", "[h", function()
	-- 	if vim.wo.diff then
	-- 		vim.cmd.normal({ "[h", bang = true })
	-- 	else
	-- 		gitsigns.nav_hunk("prev")
	-- 	end
	-- end)

	hydra_utils.setup_bidirectional_hydra("n", "hunk", "[h", "]h", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[h", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end, function()
		if vim.wo.diff then
			vim.cmd.normal({ "]h", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end, { buffer = bufnr })

	-- Actions
	map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
	map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })

	map("v", "<leader>hs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Stage Hunk" })

	map("v", "<leader>hr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Reset Hunk" })

	map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
	map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
	map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
	map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview Hunk Inline" })

	map("n", "<leader>hI", gitsigns.reset_buffer_index, { desc = "Reset Buffer Index" })

	map("n", "<leader>hb", function()
		gitsigns.blame_line({ full = true })
	end, { desc = "Blame Line" })

	map("n", "<leader>hB", function()
		gitsigns.blame()
	end, { desc = "Blame" })

	map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git Diff" })

	map("n", "<leader>hD", function()
		gitsigns.diffthis("~")
	end, { desc = "Git Diff (HEAD)" })

	map("n", "<leader>hQ", function()
		gitsigns.setqflist("all")
	end, { desc = "Populate qflist with hunks (all)" })
	map("n", "<leader>hq", gitsigns.setqflist, { desc = "Populate qflist with hunks" })

	-- Toggles
	map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
	map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })
	map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle Word diff" })

	-- Text object
	map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select Hunk" })
end

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = on_attach,
		preview_config = {
			border = "rounded",
		},
	},
}

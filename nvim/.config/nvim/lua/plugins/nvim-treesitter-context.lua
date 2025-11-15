return {
	"nvim-treesitter/nvim-treesitter-context",
	lazy = false,
	opts = { mode = "cursor", multiline_threshold = 1--[[ , max_lines = 5  ]]},
	init = function()
		vim.api.nvim_set_hl(0, "TreesitterContext", { link = "MiniStatuslineInactive" })
		vim.api.nvim_set_hl(0, "TreesitterContextBottom", { sp = "#F5E0DD", underline = true })
		vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { sp = "#F5E0DD", underline = false })
		vim.keymap.set("n", "<leader>c", function()
			require("treesitter-context").go_to_context(vim.v.count1)
		end, { silent = true })
	end,
}

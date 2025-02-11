return {
	"gbprod/yanky.nvim",
	dependencies = {
		{ "kkharji/sqlite.lua" },
	},
	keys = {
		{ "<leader>y", "<cmd>YankyRingHistory<cr>", desc = "Open Yank History" },
		{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
		{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
		{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
		{ "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
		{ "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
		{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
		{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
		{ "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
		{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
		{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
		{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
		{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
		{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
		{ "<leader>p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
		{ "<leader>P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
	},
	config = function()
		local utils = require("yanky.utils")
		require("yanky").setup({
			ring = {
				storage = "sqlite",
			},
			preserve_cursor_position = {
				enabled = true,
			},
			textobj = {
				enabled = true,
			},
			highlight = {
				on_put = false,
				on_yank = false,
			},
			picker = {
				select = {
					action = require("yanky.picker").actions.set_register(utils.get_default_register()),
				},
			},
		})
		vim.keymap.set({ "o", "x" }, "<M-p>", function()
			require("yanky.textobj").last_put()
		end, { desc = "Last Put Text Object" })
	end,
}

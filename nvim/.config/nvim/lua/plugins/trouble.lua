return {
	"folke/trouble.nvim",
	cmd = { "Trouble" },
	opts = { use_diagnostic_signs = true },
	-- specs = {
	-- 	"folke/snacks.nvim",
	-- 	opts = function(_, opts)
	-- 		return vim.tbl_deep_extend("force", opts or {}, {
	-- 			picker = {
	-- 				actions = require("trouble.sources.snacks").actions,
	-- 				win = {
	-- 					input = {
	-- 						keys = {
	-- 							["<M-t>"] = {
	-- 								"trouble_open",
	-- 								mode = { "n", "i" },
	-- 							},
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}

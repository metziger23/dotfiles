return {
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	config = true,
	opts = {
		keymaps = {
			openNextLocation = { n = "<M-Down>" },
			openPrevLocation = { n = "<M-Up>" },
			applyNext = { n = "<C-Down>" },
			applyPrev = { n = "<C-Up>" },
		},
	},
	keys = {
		{
			"<leader>r",
			function()
				require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
			end,
			mode = { "n", "v" },
			desc = "Search and Replace (current buf)",
		},
		{
			"<leader>R",
			function()
				require("grug-far").open()
			end,
			mode = { "n", "v" },
			desc = "Search and Replace",
		},
	},
}

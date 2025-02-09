return {
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	config = true,
	opts = {
		keymaps = {
			openNextLocation = { n = "<C-Down>" },
			openPrevLocation = { n = "<C-Up>" },
			applyNext = { n = "<M-Down>" },
			applyPrev = { n = "<M-Up>" },
		},
	},
	keys = {
		{
			"<leader>r",
			function()
				require("grug-far").open()
			end,
			mode = { "n", "v" },
			desc = "Search and Replace",
		},
	},
}

return {
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	config = true,
	opts = {
		keymaps = {
			applyNext = { n = "<C-Down>" },
			applyPrev = { n = "<C-Up>" },
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

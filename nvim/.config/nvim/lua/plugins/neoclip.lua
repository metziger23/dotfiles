return {
	"AckslD/nvim-neoclip.lua",
	dependencies = {
		{ "kkharji/sqlite.lua", module = "sqlite" },
		-- you'll need at least one of these
		-- {'nvim-telescope/telescope.nvim'},
		{ "ibhagwan/fzf-lua" },
	},
	opts = {},
	keys = {
		{
			"<leader>y",
			function()
				require("neoclip.fzf")()
			end,
			desc = "Neoclip",
			mode = { "n", "x" },
		},
	},
}

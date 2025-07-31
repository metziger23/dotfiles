return {
	"AckslD/nvim-neoclip.lua",
	dependencies = {
		{ "kkharji/sqlite.lua", module = "sqlite" },
		-- you'll need at least one of these
		-- {'nvim-telescope/telescope.nvim'},
		{ "ibhagwan/fzf-lua" },
	},
	lazy = false, -- NOTE: otherwise yanks won't be saved before setup
	opts = {
		enable_persistent_history = true,
	},
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

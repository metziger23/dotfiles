return {
	"ariel-frischer/bmessages.nvim",
	event = "CmdlineEnter",
	opts = {},
	keys = {
		{
			"<leader>m",
			function()
				require("bmessages").toggle({ split_type = "vsplit" })
			end,
			desc = "Bmessages vsplit",
		},
	},
}

return {
	{
		"stevearc/quicker.nvim",
		event = "VeryLazy",
		opts = {
			keys = {
				{
					">",
					function()
						require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
					end,
					desc = "Expand quickfix context",
				},
				{
					"<",
					function()
						require("quicker").collapse()
					end,
					desc = "Collapse quickfix context",
				},
			},
		},
		keys = {
			{
				"<C-q>",
				function()
					require("quicker").toggle({ open_cmd_mods = { split = "botright" } })
				end,
				desc = "Toggle quickfix",
			},
			{
				"<M-C-q>",
				function()
					require("quicker").toggle({ loclist = true, open_cmd_mods = { split = "botright" } })
				end,
				desc = "Toggle loclist",
			},
		},
	},
}

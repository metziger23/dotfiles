return {
	"folke/trouble.nvim",
	cmd = { "TroubleToggle", "Trouble" },
	opts = { use_diagnostic_signs = true },
	keys = {
		{
			"<leader>xx",
			function()
				require("trouble").toggle()
			end,
			desc = "Toggle trouble",
		},
		{
			"<leader>xr",
			function()
				require("trouble").toggle("lsp_references")
			end,
			desc = "Toggle trouble lsp references",
		},
		{
			"<leader>xw",
			function()
				require("trouble").toggle("workspace_diagnostics")
			end,
			desc = "Trouble toggle workspace diagnostics",
		},
		{
			"<leader>xd",
			function()
				require("trouble").toggle("document_diagnostics")
			end,
			desc = "Trouble toggle document diagnostics",
		},
        {
			"<leader>xq",
			function()
				require("trouble").toggle("quickfix")
			end,
			desc = "Trouble toggle quickfix",
		},
        {
			"<leader>xl",
			function()
				require("trouble").toggle("loclist")
			end,
			desc = "Trouble toggle loclist",
		}
	},
}

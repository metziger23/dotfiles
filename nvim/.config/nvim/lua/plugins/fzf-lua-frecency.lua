return {
	"elanmed/fzf-lua-frecency.nvim",
  enabled = false,
	dependencies = { "ibhagwan/fzf-lua" },
	keys = {
		{
			"<BS><tab>",
			function()
				require("fzf-lua-frecency").frecency({
					cwd_only = true,
				})
			end,
			desc = "Fzf frecency",
			mode = { "n", "x" },
		},
	},
	opts = {},
}

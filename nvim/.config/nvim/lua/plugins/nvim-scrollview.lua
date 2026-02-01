return {
	enabled = false,
	"dstein64/nvim-scrollview",
	event = { "BufReadPre", "BufNewFile" },
	after = "gitsigns.nvim",
	config = function()
		require("scrollview").setup({
			-- current_only = true,
			signs_on_startup = { "diagnostics", "folds", "search" },
		})
		require("scrollview.contrib.gitsigns").setup()
	end,
}

return {
	"arnamak/stay-centered.nvim",
	lazy = false,
	-- enabled = false,
	config = function()
		require("stay-centered").setup({
			-- Add any configurations here, like skip_filetypes if needed
			skip_filetypes = { "kitty-scrollback" },
			-- fix for https://github.com/arnamak/stay-centered.nvim/issues/23
			allow_scroll_move = false,
		})
	end,
}

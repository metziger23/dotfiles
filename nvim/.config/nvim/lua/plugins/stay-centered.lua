return {
	"arnamak/stay-centered.nvim",
	lazy = false,
	config = function()
		require("stay-centered").setup({
			-- Add any configurations here, like skip_filetypes if needed
			skip_filetypes = { "kitty-scrollback" },
		})
	end,
}

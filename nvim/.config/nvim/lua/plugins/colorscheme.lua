return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				floating_border = "on",
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}

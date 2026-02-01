return {
	"folke/which-key.nvim",
	event = "VeryLazy",
  -- fix for https://github.com/folke/which-key.nvim/issues/807
  tag = "v3.4.0",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		win = {
			border = "rounded",
		}, -- refer to the configuration section below
	},
}

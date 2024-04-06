return {
	-- https://github.com/RRethy/vim-illuminate
	"RRethy/vim-illuminate",
	event = "VeryLazy",
	dependencies = { "folke/which-key.nvim" },
	config = function()
		local illuminate = require("illuminate")
		illuminate.configure({
			delay = 250,
		})

	end,
}

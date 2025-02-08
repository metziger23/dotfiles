return {
	"akinsho/bufferline.nvim",
  event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			-- mode = "tabs",
		},
	},
	keys = {
		{ "<S-l>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<S-h>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
	},
}

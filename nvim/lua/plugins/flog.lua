return {
	"rbong/vim-flog",
	lazy = true,
	cmd = { "Flog", "Flogsplit", "Floggit" },
	dependencies = {
		"tpope/vim-fugitive",
	},
	keys = {
		{ "<leader>f", "<cmd>Flog<cr>", desc = "Flog" },
		{ "<leader>F", "<cmd>Flogsplit<cr>", desc = "Flogsplit" },
	},
}

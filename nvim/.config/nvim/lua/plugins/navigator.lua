return {
	"numToStr/Navigator.nvim",
  lazy = false,
	config = function()
		require("Navigator").setup()
		vim.keymap.set({ "n", "t" }, "<c-h>", "<CMD>NavigatorLeft<CR>")
		vim.keymap.set({ "n", "t" }, "<c-j>", "<CMD>NavigatorDown<CR>")
		vim.keymap.set({ "n", "t" }, "<c-k>", "<CMD>NavigatorUp<CR>")
		vim.keymap.set({ "n", "t" }, "<c-l>", "<CMD>NavigatorRight<CR>")
		vim.keymap.set({ "n", "t" }, "<c-\\>", "<CMD>NavigatorPrevious<CR>")
	end,
}

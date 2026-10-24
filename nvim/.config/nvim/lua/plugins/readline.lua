return {
	"assistcontrol/readline.nvim",
	init = function()
		local readline = require("readline")
		vim.keymap.set("!", "<M-d>", readline.kill_word)
		vim.keymap.set("!", "<M-BS>", readline.backward_kill_word)
		vim.keymap.set("!", "<C-BS>", readline.unix_word_rubout)
		vim.keymap.set("!", "<C-k>", readline.kill_line)
	end,
}

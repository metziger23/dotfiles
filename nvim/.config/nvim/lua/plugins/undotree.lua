return {
	"https://github.com/mbbill/undotree", -- visual undo tree
	keys = {
		{ "<leader>u", "<Cmd>UndotreeToggle<CR>", desc = "Toggle undotree window", mode = "n", silent = true },
	},
	config = function()
		vim.g.undotree_WindowLayout = 2
		vim.g.Undotree_CustomMap = function()
      -- stylua: ignore start  
      vim.api.nvim_buf_set_keymap(0, "n", "<S-Down>", "<plug>UndotreePreviousState", { noremap = true, silent = true })
			vim.api.nvim_buf_set_keymap(0, "n", "<S-Up>", "<plug>UndotreeNextState", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<C-Down>", "<plug>UndotreePreviousSavedState", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(0, "n", "<C-Up>", "<plug>UndotreeNextSavedState", { noremap = true, silent = true })
			-- stylua: ignore end
		end
	end,
}

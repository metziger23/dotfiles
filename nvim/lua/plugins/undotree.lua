return {
	"https://github.com/mbbill/undotree", -- visual undo tree
	keys = {
		{ "<leader>u", "<Cmd>UndotreeToggle<CR>", desc = "Toggle undotree window", mode = "n", silent = true },
	},
	config = function()
		vim.g.undotree_WindowLayout = 2
		vim.g.Undotree_CustomMap = function()
      -- stylua: ignore start  
      local opts = { noremap = true, silent = true }
      opts.desc = "Undotree Previous State"
      vim.api.nvim_buf_set_keymap(0, "n", "<S-Down>", "<plug>UndotreePreviousState", opts)
      opts.desc = "Undotree Next State"
			vim.api.nvim_buf_set_keymap(0, "n", "<S-Up>", "<plug>UndotreeNextState", opts)
      opts.desc = "Undotree Previous Saved State"
      vim.api.nvim_buf_set_keymap(0, "n", "<C-Down>", "<plug>UndotreePreviousSavedState", opts)
      opts.desc = "Undotree Next Saved State"
      vim.api.nvim_buf_set_keymap(0, "n", "<C-Up>", "<plug>UndotreeNextSavedState", opts)
			-- stylua: ignore end
		end
	end,
}

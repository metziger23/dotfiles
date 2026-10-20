return {

	"tpope/vim-fugitive",
	-- enabled = false,
	config = function()
		-- Optional: Add your keymaps here
		-- vim.keymap.set("n", "<M-g>", "<cmd>Git<CR>", { desc = "Git status" })
    vim.keymap.set("n", "g<CR>", "<cmd>tab Git<CR>", { desc = "Git" })
    vim.keymap.set("n", "g<BS>z", "<cmd>Gclog -g stash<CR>", { desc = "Git show stashes in quickfix" })
		-- ... other keymaps

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			callback = function()
				vim.opt_local.bufhidden = ""
			end,
		})

		vim.cmd([[
      let g:fugitive_focus_gained = v:false
      ]])
	end,
}

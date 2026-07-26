return {

	"tpope/vim-fugitive",
	-- enabled = false,
	config = function()
		-- Optional: Add your keymaps here
		-- vim.keymap.set("n", "<M-g>", "<cmd>Git<CR>", { desc = "Git status" })
    vim.keymap.set("n", "g<CR>", "<cmd>Git<CR>", { desc = "Git" })
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

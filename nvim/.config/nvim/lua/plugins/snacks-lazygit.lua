local function toggle_lazygit(open_lazygit_callback, open_lazygit_callback_opts)
	open_lazygit_callback_opts = open_lazygit_callback_opts or {}
	local float_term = open_lazygit_callback(open_lazygit_callback_opts)
	local created_buffer = float_term.buf
	local opts = { desc = "Toggle Lazygit" }

	vim.api.nvim_buf_set_keymap(created_buffer, "t", "<M-g>", "<cmd>close<CR>", opts)

	vim.api.nvim_create_autocmd({ "VimResized" }, {
		buffer = created_buffer,
		callback = function()
			vim.api.nvim_input([[<C-\><C-n>^i]])
		end,
	})
end

return {
	"folke/snacks.nvim",
	opts = {
		lazygit = {
			-- your lazygit configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	keys = {
		{
			"<M-g>",
			function()
        local callback = require("snacks").lazygit.open
				toggle_lazygit(callback)
			end,
			desc = "Lazygit",
		},
		{
			"<M-C-g>",
			function()
        local callback = require("snacks").lazygit.open
        local opts = { cwd = require("snacks").git.get_root() }
        toggle_lazygit(callback, opts)
			end,
			desc = "Lazygit current buffer git root",
		},
	},
}

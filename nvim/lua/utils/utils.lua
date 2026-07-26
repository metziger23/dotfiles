local M = {}

function M.setup_new_tab_breakout_keymap(bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }
	opts.desc = "Break out into a new tab"
	vim.keymap.set("n", "<C-w>T", "<C-w>H<C-w>T", opts)
end

return M

return {
	"mrjones2014/smart-splits.nvim",
	config = function()
    local smart_splits = require("smart-splits")
		smart_splits.setup({
      multiplexer_integration = false,
    })

		local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    opts.desc = "Resize Left"
		keymap.set("n", "<A-h>", smart_splits.resize_left, opts)
    opts.desc = "Resize Down"
		keymap.set("n", "<A-j>", smart_splits.resize_down, opts)
    opts.desc = "Resize Up"
		keymap.set("n", "<A-k>", smart_splits.resize_up, opts)
    opts.desc = "Resize Right"
		keymap.set("n", "<A-l>", smart_splits.resize_right, opts)
		-- moving between splits
    opts.desc = "Move Cursor Left"
		keymap.set("n", "<C-h>", smart_splits.move_cursor_left, opts)
    opts.desc = "Move Cursor Down"
		keymap.set("n", "<C-j>", smart_splits.move_cursor_down, opts)
    opts.desc = "Move Cursor Up"
		keymap.set("n", "<C-k>", smart_splits.move_cursor_up, opts)
    opts.desc = "Move Cursor Right"
		keymap.set("n", "<C-l>", smart_splits.move_cursor_right, opts)
		-- swapping buffers between windows
    opts.desc = "Swap Buffer Left"
		keymap.set("n", "<leader><leader>h", smart_splits.swap_buf_left, opts)
    opts.desc = "Swap Buffer Down"
		keymap.set("n", "<leader><leader>j", smart_splits.swap_buf_down, opts)
    opts.desc = "Swap Buffer Up"
		keymap.set("n", "<leader><leader>k", smart_splits.swap_buf_up, opts)
    opts.desc = "Swap Buffer Right"
		keymap.set("n", "<leader><leader>l", smart_splits.swap_buf_right, opts)
	end,
}

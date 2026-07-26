return {
	"Bekaboo/dropbar.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	opts = {
		sources = {
			path = {
				modified = function(sym)
					return sym:merge({
						name_hl = "DiffAdded",
						name = sym.name .. " ",
					})
				end,
			},
		},
		bar = {
			enable = function(buf, win, _)
				buf = vim._resolve_bufnr(buf)
				if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
					return false
				end

				if
					not vim.api.nvim_buf_is_valid(buf)
					or not vim.api.nvim_win_is_valid(win)
					or vim.fn.win_gettype(win) ~= ""
					or vim.wo[win].winbar ~= ""
				then
					return false
				end

				local buf_name = vim.api.nvim_buf_get_name(buf)
				if buf_name == "" then
					return false
				end

				local stat = vim.uv.fs_stat(buf_name)
				if stat and stat.size > 1024 * 1024 then
					return false
				end

				if vim.bo[buf].bt == "terminal" then
					return false
				end

				return true
			end,
			sources = function(_, _)
				local sources = require("dropbar.sources")
				return { sources.path }
			end,
		},
		menu = {
			win_configs = {
				border = "rounded",
			},
		},
	},
	init = function()
		local dropbar_api = require("dropbar.api")
		vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
		vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
		vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
	end,
}

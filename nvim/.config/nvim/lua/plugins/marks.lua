local function preview_mark()
	local a = vim.api
	a.nvim_echo({ { "press letter mark to preview, or press <esc> to quit" } }, true, {})
	local mark = vim.fn.getchar()
	if mark == 27 then -- <esc>
		return
	else
		mark = string.char(mark)
	end

	-- clear cmdline
	vim.defer_fn(function()
		a.nvim_echo({ { "" } }, false, {})
	end, 100)

	if not mark then
		return
	end

	local pos = vim.fn.getpos("'" .. mark)
	if pos[2] == 0 then
		return
	end

	local width = a.nvim_win_get_width(0)
	local height = a.nvim_win_get_height(0)

	a.nvim_open_win(pos[1], true, {
		relative = "win",
		win = 0,
		width = math.floor(width / 2),
		height = math.floor(height / 2),
		col = math.floor(width / 4),
		row = math.floor(height / 8),
		border = "rounded",
	})
	vim.cmd("normal! `" .. mark)
	vim.cmd("normal! zz")
end

return {
	"chentoast/marks.nvim",
	event = "VeryLazy",
	config = function()
		local marks = require("marks")
		marks.preview = preview_mark
		marks.setup({
			mappings = {
				prev = false,
				next = false,
				prev_bookmark = false,
				next_bookmark = false,
			},
		})
		local hydra_utils = require("../utils/hydra_utils")
		hydra_utils.setup_bidirectional_hydra("n", "mark", "m[", "m]", function()
			marks.prev()
		end, function()
			marks.next()
		end)

		hydra_utils.setup_bidirectional_hydra("n", "bookmark", "m{", "m}", function()
			marks.prev_bookmark()
		end, function()
			marks.next_bookmark()
		end)
	end,
}

local function for_each_global_mark(callback)
	local marks = vim.fn.getmarklist()

	for _, mark_info in ipairs(marks) do
		if mark_info.mark:match("'[A-Z]") then
			local char = mark_info.mark:sub(2)
			if callback then
				callback(char, mark_info)
			end
		end
	end
end

local function is_global_mark_set(mark)
	local marks = vim.api.nvim_exec("marks", true)
	return string.find(marks, "%s" .. mark .. " ")
end

local function next_available_global_mark()
	for ascii = 65, 90 do -- ASCII values for A-Z
		local mark = string.char(ascii)
		if not is_global_mark_set(mark) then
			return mark
		end
	end
	return nil
end

local function remove_global_mark_if_exists()
	local bufnr = vim.api.nvim_get_current_buf()
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
	local mark_removed = false

	for_each_global_mark(function(char, info)
		if info.pos[1] == bufnr and info.pos[2] == row then
			vim.cmd("delmarks " .. char)
			mark_removed = true
		end
	end)

	return mark_removed
end

local function set_global_mark()
	if vim.api.nvim_buf_get_name(0) == "" then
		print("Cannot set a global mark in an unsaved buffer")
		return
	end

	local mark = next_available_global_mark()
	if mark then
		vim.cmd("mark " .. mark)
	end
end

local function toggle_global_mark()
	if not remove_global_mark_if_exists() then
		-- NOTE: to remove all marks on the current line
		require("marks").delete_line()
		set_global_mark()
	end
end

local function clear_all_global_marks()
	vim.cmd("delmarks A-Z")
end

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
			-- TODO: rewrite it via vim.keymap.set to add desc
			mappings = {
				set = "m",
				set_next = "m,",
				toggle = "m;",
				next = false,
				prev = false,
				preview = "m<leader>",
				next_bookmark = false,
				prev_bookmark = false,
				delete = "dm",
				delete_line = "dm-",
				delete_bookmark = "dm=",
				delete_buf = "dm<space>", -- NOTE: deletes only local marks
			},
		})
		local hydra_utils = require("../utils/hydra_utils")
		hydra_utils.setup_bidirectional_hydra("n", "mark", "[<BS>", "]<BS>", function()
			marks.prev()
		end, function()
			marks.next()
		end)

		hydra_utils.setup_bidirectional_hydra("n", "bookmark", "[<Del>", "]<Del>", function()
			marks.prev_bookmark()
		end, function()
			marks.next_bookmark()
		end)

		local opts = { noremap = true }
		opts.desc = "Toggle global mark"
		vim.keymap.set("n", "m:", toggle_global_mark, opts)

		opts.desc = "Clear all global marks"
		vim.keymap.set("n", "dm<BS>", clear_all_global_marks, opts)
	end,
}

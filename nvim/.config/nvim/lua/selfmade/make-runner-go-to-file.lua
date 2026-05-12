local M = {}

local function get_start_end_indices(text)
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local match_number = 1
	local start_idx = nil
	local end_idx = nil
	while true do
		start_idx, end_idx = line:find(text, match_number, true)
		if not start_idx or not end_idx then
			break
		end
		start_idx = start_idx - 1
		end_idx = end_idx - 1
		if start_idx <= col and col <= end_idx then
			break
		end

		match_number = match_number + 1
	end
	return start_idx, end_idx
end

local function get_buffer_viewport_width()
	local winid = vim.fn.win_getid()
	local info = vim.fn.getwininfo(winid)[1]
	local text_width = info.width - info.textoff
	return text_width
end

local function get_prev_line_text(row)
	if row <= 1 then
		return ""
	end

	local prev_line = vim.api.nvim_buf_get_lines(0, row - 2, row - 1, false)[1]
	if #prev_line < get_buffer_viewport_width() then
		return ""
	end

	local text = prev_line:match("^.*%s+(.+)$")
	if text then
		return text
	else
		return get_prev_line_text(row - 1) .. prev_line
	end
end

local function get_next_line_text(row)
	if row >= vim.api.nvim_buf_line_count(0) then
		return ""
	end

	local next_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
	local text = next_line:match("^(.-)%s")
	if text then
		return text
	else
		if #next_line == get_buffer_viewport_width() then
			return next_line .. get_next_line_text(row + 1)
		else
			return next_line
		end
	end
end

local function get_multiline_text(text)
	local start_idx, end_idx = get_start_end_indices(text)
	local row = vim.api.nvim_win_get_cursor(0)[1] -- 1-based
	if start_idx == 0 then
		text = get_prev_line_text(row) .. text
	end

	if end_idx + 1 >= get_buffer_viewport_width() then
		text = text .. get_next_line_text(row)
	end

	return text
end

local function get_search_helper_tag_under_cursor()
	local text = vim.fn.expand("<cword>")
	if not text or text == "" then
		return
	end
	local start_idx, end_idx = get_start_end_indices(text)
	if not start_idx or not end_idx then
		return
	end
	start_idx = start_idx + 1
	end_idx = end_idx + 1

	local tag = require("selfmade.search-helper-tag")
	local line = vim.api.nvim_get_current_line()
	if text == tag.search_helper_tag then
		local right = line:sub(end_idx + 1)
		local next_word = vim.fn.matchstr(vim.trim(right), [[\k\+]])
		if not next_word then
			return
		end

		if vim.tbl_contains(tag.colors, next_word) then
			return text .. " " .. next_word
		end
	elseif vim.tbl_contains(tag.colors, text) then
		local left = line:sub(1, start_idx - 1)
		local prev_word = vim.fn.matchstr(vim.trim(left), [[\k\+$]])
		if not prev_word then
			return
		end
		if prev_word == tag.search_helper_tag then
			return prev_word .. " " .. text
		end
	end
end

local function get_path_and_position()
	local text = get_multiline_text(vim.fn.expand("<cWORD>"))
	local path, lnum, cnum = text:match("^(.-):(%d+):(%d+)")
	if path and lnum and cnum then
		return path, lnum, cnum
	end

	path, lnum = text:match("^(.+):(%d+)")
	if path and lnum then
		return path, lnum, nil
	end

	local cfile = vim.fn.expand("<cfile>")
	return cfile, nil, nil
end

local function strip_file_prefix(path)
	return (path or ""):gsub("^file://", "")
end

local function go_to_search_helper_tag()
	local color_tag = get_search_helper_tag_under_cursor()
	if color_tag then
		local res = vim.system({
			"rg",
			"--no-heading",
			"--color",
			"never",
			"-n",
			"--column",
			"-m",
			"1",
			color_tag,
		}, { text = true }):wait()
		if res.code == 0 and res.stdout then
			local line = (res.stdout or ""):match("([^\n]+)")
			if not line or line == "" then
				return
			end

			local path, lnum, cnum = line:match("^(.+):(%d+):(%d+):")
			if path and lnum and cnum then
				local go_to_line = ([[+call\ cursor(%d,%d) ]]):format(tonumber(lnum), tonumber(cnum))
				vim.cmd("wincmd p")
				vim.cmd.find(go_to_line .. vim.fn.fnameescape(vim.trim(path)))
			end
		end
	end
end

function M.go_to_file()
	-- TODO: go to my mega tag

	-- TODO: don't open if another window is of filetype make-runner

	-- TODO: setup previous window selector like in snacks picker

	if go_to_search_helper_tag() then
		return
	end

	local path, lnum, cnum = get_path_and_position()
	path = strip_file_prefix(path)
	local go_to_line = ""
	if lnum and cnum then
		go_to_line = ([[+call\ cursor(%d,%d) ]]):format(tonumber(lnum), tonumber(cnum))
	elseif lnum then
		go_to_line = ("+%d "):format(tonumber(lnum))
	end
	path = vim.fn.expand(path)

	if vim.uv.fs_stat(path) then
		vim.cmd("wincmd p")
		vim.cmd.edit(go_to_line .. vim.fn.fnameescape(path))
		return
	end

	local res = vim.system({ "rg", "--files", "--glob", "**/" .. path }, { text = true }):wait()
	if res.code == 0 and res.stdout then
		local lines = vim.split(vim.trim(res.stdout or ""), "\n", { plain = true })
		local first_line = lines[1]
		vim.cmd("wincmd p")
		vim.cmd.find(go_to_line .. vim.fn.fnameescape(vim.trim(first_line)))
		return
	end

	res = vim.system({ "fd", "--type", "d", "--glob", "**/" .. path }, { text = true }):wait()
	if res.stdout and res.stdout ~= "" then
		local lines = vim.split(vim.trim(res.stdout or ""), "\n", { plain = true })
		local first_line = lines[1]
		vim.cmd("wincmd p")
		vim.cmd.find(go_to_line .. vim.fn.fnameescape(vim.trim(first_line)))
		return
	end
end

return M

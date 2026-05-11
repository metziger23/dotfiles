local M = {}

local function get_path_and_position()
	local cWORD = vim.fn.expand("<cWORD>")
	local path, lnum, cnum = cWORD:match("^(.-):(%d+):(%d+)")
	if path and lnum and cnum then
		return path, lnum, cnum
	end

	path, lnum = cWORD:match("^(.+):(%d+)")
	if path and lnum then
		return path, lnum, nil
	end

	local cfile = vim.fn.expand("<cfile>")
	return cfile, nil, nil
end

local function strip_file_prefix(path)
	return (path or ""):gsub("^file://", "")
end

function M.go_to_file()
	-- TODO: go to my mega tag N1ZpIq

	-- TODO: don't open if another window is of filetype make-runner

	-- TODO: setup previous window selector like in snacks picker

	-- TODO: support multiline paths

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

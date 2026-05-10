local M = {}

local function get_path_and_lnum()
	local cWORD = vim.fn.expand("<cWORD>")
	local path, lnum = cWORD:match("^(.+):(%d+)")
	if path and lnum then
		return path, lnum
	end

	local cfile = vim.fn.expand("<cfile>")
	return cfile, nil
end

function M.go_to_file()
	-- TODO: go to my mega tag N1ZpIq

	-- TODO: don't open if another window is of filetype make-runner

	-- TODO: setup previous window selector like in snacks picker

	-- TODO: support multiline paths

  -- TODO: support paths like this file:///home/mikhail
	local path, lnum = get_path_and_lnum()
	local go_to_line = ""
	if lnum then
		go_to_line = "+" .. lnum .. " "
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

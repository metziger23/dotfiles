local M = {}

function M.generate_make()
   if(vim.fn.has("unix")) then
        return "/usr/bin/make"
    end
end

function M.get_number_of_cores()
    if(vim.fn.has("unix")) then
        return vim.fn.system("nproc")
    end
end


-- see if the file exists
local function file_exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
local function lines_from(file)
	if not file_exists(file) then
		return {}
	end
	local lines = {}
	for line in io.lines(file) do
		lines[#lines + 1] = line
	end
	return lines
end

local function words_from_line(line)
	local words = {}
	for word in line:gmatch("[^%s]+") do
		table.insert(words, word)
	end
	return words
end

function M.get_target_from_Makefile()
	local lines = lines_from("Makefile")
	for _, v in pairs(lines) do
		local words = words_from_line(v)
		if #words >= 3 and words[1] == "TARGET" and words[2] == "=" then
			return words[3]
		end
	end
end

return M

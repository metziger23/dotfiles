local M = {}

function M.generate_build_type_param(build_type)
	if build_type == "debug" then
		return "CONFIG+=debug"
	elseif build_type == "release" then
		return ""
	end
end

function M.generate_spec()
	if vim.fn.has("mac") == 1 then
		return "macx-clang"
	elseif vim.fn.has("linux") == 1 then
		return "linux-g++"
	end
end

function M.generate_qmake()
	if vim.fn.has("mac") == 1 then
		return "/opt/homebrew/Cellar/qt/6.6.2_1/bin/qmake"
	elseif vim.fn.has("linux") == 1 then
		return "qmake"
	end
end

return M

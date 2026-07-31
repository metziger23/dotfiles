local js_like = {
	left = 'console.info("',
	right = '")',
	mid_var = '", ',
	right_var = ")",
}

local qt_like = {
	left = 'qInfo() << "',
	right = '";',
	mid_var = '" << ',
	right_var = ";",
}

local function join_work_under_the_cursor_qml(name, buf)
	local lnum = vim.api.nvim_win_get_cursor(0)[1] -- 1-based
	if lnum <= 1 then
		return
	end

	if not name or name == "" then
		return
	end

	local prev_lnum0 = lnum - 2
	local cur_lnum0 = lnum - 1

	local prev = vim.api.nvim_buf_get_lines(buf, prev_lnum0, prev_lnum0 + 1, false)[1] or ""
	local indent = prev:match("^%s*") or ""

	-- убрать ";" в конце строки (с пробелами), затем добавить " <<"
	local new_prev = prev
		:gsub("%s*;%s*$", "") -- remove trailing semicolon
    :gsub("%s*%)%s*$", "") -- remove trailing paren
		:gsub("%s*$", "") -- trim end
		.. ","

  local safe_name = name:gsub("%%", "%%%%")
  local new_cur = indent .. string.format([["%s", %s);]], safe_name, safe_name)

	vim.api.nvim_buf_set_lines(buf, prev_lnum0, prev_lnum0 + 1, false, { new_prev })
	vim.api.nvim_buf_set_lines(buf, cur_lnum0, cur_lnum0 + 1, false, { new_cur })
end

local function join_work_under_the_cursor_cpp(name, buf)
	local lnum = vim.api.nvim_win_get_cursor(0)[1] -- 1-based
	if lnum <= 1 then
		return
	end

	if not name or name == "" then
		return
	end

	local prev_lnum0 = lnum - 2
	local cur_lnum0 = lnum - 1

	local prev = vim.api.nvim_buf_get_lines(buf, prev_lnum0, prev_lnum0 + 1, false)[1] or ""
	local indent = prev:match("^%s*") or ""

	-- убрать ";" в конце строки (с пробелами), затем добавить " <<"
	local new_prev = prev
		:gsub("%s*;%s*$", "") -- remove trailing semicolon
		:gsub("%s*$", "") -- trim end
		.. " <<"

	local new_cur = indent .. string.format([["%s" << %s;]], name, name)

	vim.api.nvim_buf_set_lines(buf, prev_lnum0, prev_lnum0 + 1, false, { new_prev })
	vim.api.nvim_buf_set_lines(buf, cur_lnum0, cur_lnum0 + 1, false, { new_cur })
end

return {
	"andrewferrier/debugprint.nvim", -- opts = {},
	enabled = true,

	dependencies = {
		-- "echasnovski/mini.nvim", -- Optional: Needed for line highlighting (full mini.nvim plugin)
		-- ... or ...
		-- "echasnovski/mini.hipatterns", -- Optional: Needed for line highlighting ('fine-grained' hipatterns plugin)

		-- "ibhagwan/fzf-lua", -- Optional: If you want to use the `:Debugprint search` command with fzf-lua
		-- "nvim-telescope/telescope.nvim", -- Optional: If you want to use the `:Debugprint search` command with telescope.nvim
		{ "metziger23/snacks.nvim", branch = "fix-snacks-picker-insert" }, -- Optional: If you want to use the `:Debugprint search` command with snacks.nvim
	},

	lazy = false, -- Required to make line highlighting work before debugprint is first used
	version = "*", -- Remove if you DON'T want to use the stable version
	config = function()
		local tag = require("../selfmade/search-helper-tag")
		local counter = require("debugprint.counter")
		local default_display_counter = counter.default_display_counter

		counter.default_display_counter = function()
			local default_result = default_display_counter()
			local default_result_number = tonumber(default_result:match("%[(%d+)%]"))
			---@diagnostic disable-next-line: param-type-mismatch
			local color_number = math.fmod(default_result_number, #tag.colors) + 1
			return tag.search_helper_tag .. " " .. tag.colors[color_number]
		end

		require("debugprint").setup({
			display_location = false,
			print_tag = "",
			keymaps = {
				normal = {
					plain_below = "gls",
					plain_above = "glr",
					variable_below = "gle",
					variable_above = "gli",
					variable_below_alwaysprompt = "glf",
					variable_above_alwaysprompt = "glw",
					surround_plain = "gla",
					surround_variable = "glc",
					surround_variable_alwaysprompt = "glx",
					textobj_below = "glu",
					textobj_above = "gly",
					textobj_surround = "glo",
					toggle_comment_debug_prints = "gl<BS>",
					delete_debug_prints = "gl<Del>",
				},
				insert = {
					plain = "<C-G>e",
					variable = "<C-G>i",
				},
				visual = {
					variable_below = "gle",
					variable_above = "gli",
				},
			},
			filetypes = {
				["cpp"] = qt_like,
				["javascript"] = js_like,
				["javascriptreact"] = js_like,
				["typescript"] = js_like,
				["typescriptreact"] = js_like,
				["qml"] = js_like,
			},
		})

		vim.fn.setreg("n", tag.search_helper_tag)
		local group = vim.api.nvim_create_augroup("CppFtMaps", { clear = true })

		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = { "cpp", "c", "objc", "objcpp" },
			callback = function(ev)
				local buf = ev.buf

				vim.keymap.set("n", "<leader>j", function()
					join_work_under_the_cursor_cpp(vim.fn.expand("<cword>"), buf)
				end, { buffer = buf, silent = true, desc = "qDebug: join cword" })

				vim.keymap.set("n", "<leader>J", function()
					join_work_under_the_cursor_cpp(vim.fn.expand("<cWORD>"), buf)
				end, { buffer = buf, silent = true, desc = "qDebug: join cWORD" })
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = { "qml" },
			callback = function(ev)
				local buf = ev.buf

				vim.keymap.set("n", "<leader>j", function()
					join_work_under_the_cursor_qml(vim.fn.expand("<cword>"), buf)
				end, { buffer = buf, silent = true, desc = "qDebug: join cword" })

				vim.keymap.set("n", "<leader>J", function()
					join_work_under_the_cursor_qml(vim.fn.expand("<cWORD>"), buf)
				end, { buffer = buf, silent = true, desc = "qDebug: join cWORD" })
			end,
		})

	end,
}

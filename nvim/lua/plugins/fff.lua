local cword = nil
local cWORD = nil
local cfile = nil
local afile = nil

local function setup_words()
	cword = vim.fn.expand("<cword>")
	cWORD = vim.fn.expand("<cWORD>")
	cfile = vim.fn.expand("<cfile>")
	afile = vim.fn.expand("<afile>")
end

local function setup_words_keymaps()
	local function set_keymap(keymap, text, desc, ev)
		vim.keymap.set("i", keymap, function()
			if text then
				vim.api.nvim_paste(text, false, -1)
			end
		end, { buffer = ev.buf, silent = true, desc = desc })
	end

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "fff_input",
		callback = function(ev)
			set_keymap("<C-r><C-w>", cword, "Insert cword", ev)
			set_keymap("<C-r><C-a>", cWORD, "Insert cWORD", ev)
			set_keymap("<C-r><C-f>", cfile, "Insert cfile", ev)
		end,
	})
end

local function fullscreen_current_float()
	local win = vim.api.nvim_get_current_win()

	local cfg = vim.api.nvim_win_get_config(win)
	if cfg.relative == "" then
		error("Текущее окно не floating window")
	end

	local ui = vim.api.nvim_list_uis()[1]
	vim.api.nvim_win_set_config(
		win,
		vim.tbl_extend("force", cfg, {
			relative = "editor",
			row = 0,
			col = 0,
			width = ui.width,
			height = ui.height,
		})
	)
end

return {
	"dmtrKovalenko/fff.nvim",
	enabled = true,
	build = function()
		-- downloads a prebuilt binary or falls back to cargo build
		require("fff.download").download_or_build_binary()
	end,
	init = function()
		setup_words_keymaps()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fff*",
			callback = function(ev)
				vim.keymap.set({ "n", "i" }, "<M-m>", fullscreen_current_float, {
					buffer = ev.buf,
					silent = true,
					desc = "fullscreen_current_float",
				})
			end,
		})
	end,
	-- for nixos:
	-- build = "nix run .#release",
	opts = {
		prompt_vim_mode = true,
		-- debug = {
		-- 	enabled = true,
		-- 	show_scores = true,
		-- },
		layout = {
			height = 0.8,
			width = 0.8,
			prompt_position = "top", -- or 'top'
			preview_position = "right", -- 'left' | 'right' | 'top' | 'bottom'
			preview_size = 0.5,
			flex = { size = 130, wrap = "top" },
			show_scrollbar = true,
			path_shorten_strategy = "middle_number", -- 'middle_number' | 'middle' | 'end'
			anchor = "center",
		},
	},
	lazy = false, -- the plugin lazy-initialises itself
	keys = {
		{
			"<leader><leader>",
			function()
				setup_words()
				require("fff").find_files()
			end,
			desc = "FFFind files",
		},
		-- {
		-- 	"<BS><tab>",
		-- 	function()
		-- 		setup_words()
		-- 		require("fff").find_files()
		-- 	end,
		-- 	desc = "FFFind files",
		-- },
		-- {
		-- 	"<BS><leader>",
		-- 	function()
		-- 		require("fff").live_grep({ grep_modes = { "regex", "fuzzy", "plain" } })
		-- 	end,
		-- 	desc = "LiFFFe grep",
		-- },
		-- -- {
		-- -- 	"<BS><leader>",
		-- -- 	function()
		-- -- 		require("fff").live_grep({ grep = { modes = { "regex", "fuzzy", "plain" } } })
		-- -- 	end,
		-- -- 	desc = "Live fffuzy grep",
		-- -- },
		-- {
		-- 	"<BS>w",
		-- 	function()
		-- 		require("fff").live_grep_under_cursor()
		-- 	end,
		-- 	desc = "Search current word",
		-- 	mode = { "n", "x" },
		-- },
	},
}

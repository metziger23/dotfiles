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
	end,
}

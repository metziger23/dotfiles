-- stylua: ignore start
local colors = {
	"red", "green", "blue", "orange", "purple",
	"teal", "pink", "lime", "white", "navy", "olive",
	 "silver", "gray", "gold", "cyan", "magenta",
  "brown", "darkgreen", "skyblue", "indigo",
  "coral", "yellow", "violet", "firebrick",
	 "royalblue", "sienna", "tomato", "slateblue",
}
-- stylua: ignore end

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

	dependencies = {
		-- "echasnovski/mini.nvim", -- Optional: Needed for line highlighting (full mini.nvim plugin)
		-- ... or ...
		-- "echasnovski/mini.hipatterns", -- Optional: Needed for line highlighting ('fine-grained' hipatterns plugin)

		-- "ibhagwan/fzf-lua", -- Optional: If you want to use the `:Debugprint search` command with fzf-lua
		-- "nvim-telescope/telescope.nvim", -- Optional: If you want to use the `:Debugprint search` command with telescope.nvim
		"folke/snacks.nvim", -- Optional: If you want to use the `:Debugprint search` command with snacks.nvim
	},

	lazy = false, -- Required to make line highlighting work before debugprint is first used
	version = "*", -- Remove if you DON'T want to use the stable version
	config = function()
		local counter = require("debugprint.counter")
		local default_display_counter = counter.default_display_counter

		counter.default_display_counter = function()
			local default_result = default_display_counter()
			local default_result_number = tonumber(default_result:match("%[(%d+)%]"))
			---@diagnostic disable-next-line: param-type-mismatch
			local color_number = math.fmod(default_result_number, #colors) + 1
			return colors[color_number]
		end

		require("debugprint").setup({
			display_location = false,
			print_tag = "",
			keymaps = {
				normal = {
					plain_below = "<M-n>p",
					plain_above = "<M-n>P",
					variable_below = "<M-n>v",
					variable_above = "<M-n>V",
					variable_below_alwaysprompt = "",
					variable_above_alwaysprompt = "",
					surround_plain = "<M-n>sp",
					surround_variable = "<M-n>sv",
					surround_variable_alwaysprompt = "",
					textobj_below = "<M-n>o",
					textobj_above = "<M-n>O",
					textobj_surround = "<M-n>so",
					toggle_comment_debug_prints = "",
					delete_debug_prints = "",
				},
				insert = {
					plain = "<M-n>p",
					variable = "<M-n>v",
				},
				visual = {
					variable_below = "<M-n>v",
					variable_above = "<M-n>V",
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
	end,
}

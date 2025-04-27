local edit_cmd = {
	edit = "buffer",
	split = "sbuffer",
	vsplit = "vert sbuffer",
	tab = "tab sbuffer",
	drop = "drop",
	tabdrop = "tab drop",
}

local function zoxide_picker(cd_callback)
	require("snacks").picker.zoxide({
		format = "text",
		confirm = function(picker, item, action)
			picker:close()
			if item and item.dir and item.file then
				if action and action.cmd then
					local cmd = vim.cmd(edit_cmd[action.cmd])
					if cmd ~= nil then
						vim.cmd(cmd)
					end
				end

				---@diagnostic disable-next-line: undefined-global
				cd_callback(_, item)
				vim.cmd("e .")
			end
		end,
		win = {
			input = {
				keys = {
					["<S-CR>"] = { { "pick_win", "confirm" }, mode = { "n", "i" } },
				},
			},
			list = {
				keys = {
					["<S-CR>"] = { { "pick_win", "confirm" } },
				},
			},
		},
	})
end

local select_preset = {
	layout = {
		preset = "select",
	},
}

local explorer_options = {
	win = {
		list = {
			keys = {
				-- NOTE: use flash instead of default ones
				["l"] = false,
				["h"] = false, -- close directory
				-- NOTE: toggle_hidden is still available with "<M-h>"
				["H"] = "explorer_close",
			},
		},
	},
}

local arrow_keymaps_for_pinning = {
	["<C-w><S-Left>"] = "layout_left",
	["<C-w><S-Down>"] = "layout_bottom",
	["<C-w><S-Up>"] = "layout_top",
	["<C-w><S-Right>"] = "layout_right",
}

return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			-- NOTE: to be able to reuse window opened from oil
			-- https://github.com/folke/snacks.nvim/issues/618
			main = { current = true },
			win = {
				input = {
					keys = arrow_keymaps_for_pinning,
				},
				list = {
					keys = arrow_keymaps_for_pinning,
				},
			},
		},
	},
	event = "VeryLazy",
	keys = {
    -- stylua: ignore start
    { "<BS>a", function() require("snacks").picker.autocmds() end, desc = "Autocmds", mode = { "n", "x" }  },
    { "<BS>b", function() require("snacks").picker.buffers() end, desc = "Buffers", mode = { "n", "x" }  },
    { "<BS>h", function() require("snacks").picker.command_history(select_preset) end, desc = "Command History", mode = { "n", "x" }  },
    { "<BS>c", function() require("snacks").picker.commands() end, desc = "Commands", mode = { "n", "x" }  },
    { "<BS>e", function() require("snacks").picker.explorer(explorer_options) end, desc = "Explorer", mode = { "n", "x" }  },
    { "<BS>f", function() require("snacks").picker.files() end, desc = "Files", mode = { "n", "x" }  },
    { "<BS>gb", function() require("snacks").picker.git_branches() end, desc = "Git Branches", mode = { "n", "x" }  },
    { "<BS>gd", function() require("snacks").picker.git_diff() end, desc = "Git Diff", mode = { "n", "x" }  },
    { "<BS>gf", function() require("snacks").picker.git_files() end, desc = "Git Files", mode = { "n", "x" }  },
    { "<BS>gl", function() require("snacks").picker.git_log() end, desc = "Git Log", mode = { "n", "x" }  },
    { "<BS>gF", function() require("snacks").picker.git_log_file() end, desc = "Git Log File", mode = { "n", "x" }  },
    { "<BS>gL", function() require("snacks").picker.git_log_line() end, desc = "Git Log Line", mode = { "n", "x" }  },
    { "<BS>gs", function() require("snacks").picker.git_status() end, desc = "Git Status", mode = { "n", "x" }  },
    { "<BS><leader>", function() require("snacks").picker.grep() end, desc = "Grep", mode = { "n", "x" }  },
    { "<BS>,", function() require("snacks").picker.grep_buffers() end, desc = "Grep Buffers", mode = { "n", "x" }  },
    { "<BS>w", function() require("snacks").picker.grep_word() end, desc = "Grep Word", mode = { "n", "x" } },
    { "<BS>p", function() require("snacks").picker.help() end, desc = "Help", mode = { "n", "x" }  },
    { "<BS>j", function() require("snacks").picker.jumps() end, desc = "Jumps", mode = { "n", "x" }  },
    { "<BS>k", function() require("snacks").picker.keymaps() end, desc = "Keymaps", mode = { "n", "x" }  },
    { "<BS>l", function() require("snacks").picker.lines() end, desc = "Lines", mode = { "n", "x" }  },
    { "<BS>L", function() require("snacks").picker.loclist() end, desc = "Loclist", mode = { "n", "x" }  },
    { "<BS>M", function() require("snacks").picker.man() end, desc = "Man", mode = { "n", "x" }  },
    { "<BS>m", function() require("snacks").picker.marks() end, desc = "Marks", mode = { "n", "x" }  },
    { "<BS>P", function() require("snacks").picker.pickers() end, desc = "Pickers", mode = { "n", "x" }  },
    { "<BS>q", function() require("snacks").picker.qflist() end, desc = "Quickfix List", mode = { "n", "x" }  },
    { "<BS>o", function() require("snacks").picker.recent() end, desc = "Old Files", mode = { "n", "x" }  },
    { "<BS>R", function() require("snacks").picker.registers() end, desc = "Registers", mode = { "n", "x" }  },
    { "<BS>r", function() require("snacks").picker.resume() end, desc = "Resume", mode = { "n", "x" }  },
    { "<BS>/", function() require("snacks").picker.search_history(select_preset) end, desc = "Search History", mode = { "n", "x" }  },
    { "<BS><tab>", function() require("snacks").picker.smart() end, desc = "Smart", mode = { "n", "x" }  },
    { "<BS>s", function() require("snacks").picker.spelling(select_preset) end, desc = "Spelling", mode = { "n", "x" }  },
    { "<BS>u", function() require("snacks").picker.undo() end, desc = "Undo", mode = { "n", "x" }  },
    { "<BS>zz", function() zoxide_picker(require("snacks").picker.actions.cd) end, desc = "Zoxide cd", mode = { "n", "x" }, },
    { "<BS>zl", function() zoxide_picker(require("snacks").picker.actions.lcd) end, desc = "Zoxide lcd", mode = { "n", "x" }, },
    { "<BS>zt", function() zoxide_picker(require("snacks").picker.actions.tcd) end, desc = "Zoxide tcd", mode = { "n", "x" }, },
		-- stylua: ignore end
	},
}

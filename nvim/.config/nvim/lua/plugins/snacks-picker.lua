local select_preset = {
	layout = {
		preset = "select",
	},
}

return {
	"folke/snacks.nvim",
  -- NOTE: to be able to reuse window opened from oil
  -- https://github.com/folke/snacks.nvim/issues/618
	opts = { picker = { main = { current = true } } },
  event = "VeryLazy",
	keys = {
    { "<BS>a", function() require("snacks").picker.autocmds() end, desc = "Autocmds" },
    { "<BS>b", function() require("snacks").picker.buffers() end, desc = "Buffers" },
    { "<BS>h", function() require("snacks").picker.command_history(select_preset) end, desc = "Command History" },
    { "<BS>c", function() require("snacks").picker.commands() end, desc = "Commands" },
    { "<BS>f", function() require("snacks").picker.files() end, desc = "Files" },
    { "<BS>gb", function() require("snacks").picker.git_branches() end, desc = "Git Branches" },
    { "<BS>gd", function() require("snacks").picker.git_diff() end, desc = "Git Diff" },
    { "<BS>gf", function() require("snacks").picker.git_files() end, desc = "Git Files" },
    { "<BS>gl", function() require("snacks").picker.git_log() end, desc = "Git Log" },
    { "<BS>gF", function() require("snacks").picker.git_log_file() end, desc = "Git Log File" },
    { "<BS>gL", function() require("snacks").picker.git_log_line() end, desc = "Git Log Line" },
    { "<BS>gs", function() require("snacks").picker.git_status() end, desc = "Git Status" },
    { "<BS><leader>", function() require("snacks").picker.grep() end, desc = "Grep" },
    { "<BS>B", function() require("snacks").picker.grep_buffers() end, desc = "Grep Buffers" },
    { "<BS>w", function() require("snacks").picker.grep_word() end, desc = "Grep Word", mode = { "n", "x" } },
    { "<BS>H", function() require("snacks").picker.help() end, desc = "Help" },
    { "<BS>j", function() require("snacks").picker.jumps() end, desc = "Jumps" },
    { "<BS>k", function() require("snacks").picker.keymaps() end, desc = "Keymaps" },
    { "<BS>l", function() require("snacks").picker.lines() end, desc = "Lines" },
    { "<BS>L", function() require("snacks").picker.loclist() end, desc = "Loclist" },
    { "<BS>M", function() require("snacks").picker.man() end, desc = "Man" },
    { "<BS>m", function() require("snacks").picker.marks() end, desc = "Marks" },
    { "<BS>P", function() require("snacks").picker.pickers() end, desc = "Pickers" },
    { "<BS>p", function() require("snacks").picker.projects() end, desc = "Projects" },
    { "<BS>q", function() require("snacks").picker.qflist() end, desc = "Quickfix List" },
    { "<BS>o", function() require("snacks").picker.recent() end, desc = "Old Files" },
    { "<BS>R", function() require("snacks").picker.registers() end, desc = "Registers" },
    { "<BS>r", function() require("snacks").picker.resume() end, desc = "Resume" },
    { "<BS>/", function() require("snacks").picker.search_history(select_preset) end, desc = "Search History" },
    { "<BS><tab>", function() require("snacks").picker.smart() end, desc = "Smart" },
    { "<BS>s", function() require("snacks").picker.spelling(select_preset) end, desc = "Spelling" },
    { "<BS>u", function() require("snacks").picker.undo() end, desc = "Undo" },
    { "<BS>z", function() require("snacks").picker.zoxide() end, desc = "Zoxide" },
	},
}

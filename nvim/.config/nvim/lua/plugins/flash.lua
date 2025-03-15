return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		labels = "tnseriaodhplgmfucbjvkwyxqz",
		modes = {
			char = {
				-- show jump labels
				jump_labels = true,
				-- When using jump labels, don't use these keys
				-- This allows using those keys directly after the motion
				label = { exclude = "neioardc" },
			},
		},
	},
  -- stylua: ignore
  keys = {
    { "h", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<M-h>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<M-h>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}

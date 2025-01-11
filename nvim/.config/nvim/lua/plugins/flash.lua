return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		labels = "tnseriaodhplgmfucbjvkwyxqz",
		modes = {
      search = {
        -- when `true`, flash will be activated during regular search by default.
        -- You can always toggle when searching with `require("flash").toggle()`
        enabled = true,
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

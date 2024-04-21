return {
	"gbprod/substitute.nvim",
	opts = {
    highlight_substituted_text = {
      enabled = false,
    },
	},
	keys = {
		{ "s", function() require("substitute").operator() end, mode = "n", desc = "Substitute" },
		{ "ss", function() require("substitute").line() end, mode = "n", desc = "Substitute Line" },
		{ "S", function() require("substitute").eol() end, mode = "n", desc = "Substitute EOL" },
		{ "s", function() require("substitute").visual() end, mode = "x", desc = "Substitute Visual" },
	},
}

return {
	"gbprod/substitute.nvim",
	keys = {
    -- stylua: ignore start
		{ "s", function() require("substitute").operator() end, mode = "n", desc = "Substitute" },
		{ "ss", function() require("substitute").line() end, mode = "n", desc = "Substitute Line" },
		{ "S", function() require("substitute").eol() end, mode = "n", desc = "Substitute EOL" },
		{ "s", function() require("substitute").visual() end, mode = "x", desc = "Substitute Visual" },

    { "<leader>s", function() require("substitute").operator({ modifiers = { "reindent" } }) end, mode = "n", desc = "Substitute (reindent)" },
    { "<leader>ss", function() require("substitute").line({ modifiers = { "reindent" } }) end, mode = "n", desc = "Substitute Line (reindent)" },
    { "<leader>S", function() require("substitute").eol({ modifiers = { "reindent" } }) end, mode = "n", desc = "Substitute EOL (reindent)" },
    { "<leader>s", function() require("substitute").visual({ modifiers = { "reindent" } }) end, mode = "x", desc = "Substitute Visual (reindent)" },

    {"sx", function() require("substitute.exchange").operator() end, mode = "n", desc = "Substitute Exchange" },
    {"sxx", function() require("substitute.exchange").line() end, mode = "n", desc = "Substitute Exchange Line" },
    {"X", function() require("substitute.exchange").visual() end, mode = "x", desc = "Substitute Exchange Visual" },
    {"sxc", function() require("substitute.exchange").cancel() end, mode = "n", desc = "Substitute Exchange Cancel" },
		-- stylua: ignore end
	},
	config = function()
		require("substitute").setup({
			highlight_substituted_text = {
				enabled = false,
			},
			-- on_substitute = require("yanky.integration").substitute(),
		})
	end,
}

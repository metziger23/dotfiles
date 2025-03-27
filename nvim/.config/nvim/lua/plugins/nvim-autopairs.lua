return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	config = function()
		-- import nvim-autopairs
		local autopairs = require("nvim-autopairs")

		-- configure autopairs
		autopairs.setup({
			disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
			check_ts = true, -- enable treesitter
			ts_config = {
				lua = { "string" }, -- don't add pairs in lua string treesitter nodes
			},
		})
	end,
}

local hydra_utils = require("../utils/hydra_utils")

return {
	"sindrets/diffview.nvim", -- optional - Diff integration
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = {
		"DiffviewClose",
		"DiffviewLog",
		"DiffviewOpen",
		"DiffviewRefresh",
		"DiffviewFocusFiles",
		"DiffviewFileHistory",
		"DiffviewToggleFiles",
	},
	config = function()
		local actions = require("diffview.actions")
    -- stylua: ignore start
    local entry_desc = "diff for the next file"
		local prev_entry = hydra_utils.get_single_keymap_table(false,
      "n", entry_desc, "<s-tab>", "<tab>", actions.select_prev_entry, actions.select_next_entry)
		local next_entry = hydra_utils.get_single_keymap_table(true,
      "n", entry_desc, "<s-tab>", "<tab>", actions.select_prev_entry, actions.select_next_entry)
		local prev_conflict = hydra_utils.get_single_keymap_table(false,
      "n", "conflict", "[x", "]x", actions.prev_conflict, actions.next_conflict)
		local next_conflict = hydra_utils.get_single_keymap_table(true,
      "n", "conflict", "[x", "]x", actions.prev_conflict, actions.next_conflict)
		-- stylua: ignore end
		require("diffview").setup({
			keymaps = {
				view = {
					prev_entry,
					next_entry,
					prev_conflict,
					next_conflict,
				},
			},
		})
		vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
			pattern = "diffview:///panels/*",
			callback = function()
				if vim.api.nvim_win_get_config(0).zindex then
					vim.api.nvim_win_set_config(0, { border = "rounded" })
				end
			end,
		})
	end,
}

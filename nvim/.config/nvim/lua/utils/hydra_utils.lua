local M = {}

local function single_hydra_setup(modes, desc, prev_keymap, next_keymap, prev_func, next_func, opts)
	local Hydra = require("hydra")
	local prev_desc = "Go to previous " .. desc
	local next_desc = "Go to next " .. desc
	return Hydra({
		name = "Go to next/previous " .. desc,
		mode = modes,
		config = {
			hint = { type = "window" },
			color = "pink",
		},
		heads = {
			{ prev_keymap, prev_func, vim.tbl_deep_extend("force", opts, { desc = prev_desc }) },
			{ "<PageUp>", prev_func, vim.tbl_deep_extend("force", opts, { desc = prev_desc }) },
			{ next_keymap, next_func, vim.tbl_deep_extend("force", opts, { desc = next_desc }) },
			{ "<PageDown>", next_func, vim.tbl_deep_extend("force", opts, { desc = next_desc }) },
		},
	})
end

local function single_keymap_setup(is_next, modes, desc, prev_keymap, next_keymap, prev_func, next_func, opts)
	local cur_keymap = is_next and next_keymap or prev_keymap
	local cur_func = is_next and next_func or prev_func
	local direction_desc = is_next and "next" or "previous"
	local complete_direction_desc = "Go to " .. direction_desc .. " " .. desc
	opts.desc = complete_direction_desc
	vim.keymap.set(modes, cur_keymap, function()
		cur_func()
		local hydra = single_hydra_setup(modes, desc, prev_keymap, next_keymap, prev_func, next_func, opts)
		hydra:activate()
	end, opts)
end

function M.setup_bidirectional_hydra(modes, desc, prev_keymap, next_keymap, prev_func, next_func, opts)
	opts = opts or {}
	single_keymap_setup(false, modes, desc, prev_keymap, next_keymap, prev_func, next_func, opts)
	single_keymap_setup(true, modes, desc, prev_keymap, next_keymap, prev_func, next_func, opts)
end

return M

local M = {}

local function single_hydra_setup(modes, desc, prev_keymap, next_keymap, prev_func, next_func, opts)
	local Hydra = require("hydra")
	return Hydra({
		name = "Go to next/previous " .. desc,
		mode = modes,
		config = {
			hint = { type = "window" },
			color = "pink",
		},
		heads = {
			{ prev_keymap, prev_func },
			{ "<PageUp>", prev_func },
			{ next_keymap, next_func },
			{ "<PageDown>", next_func },
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
  single_keymap_setup(false, modes, desc, prev_keymap, next_keymap, prev_func, next_func, opts)
  single_keymap_setup(true, modes, desc, prev_keymap, next_keymap, prev_func, next_func, opts)
end

return M

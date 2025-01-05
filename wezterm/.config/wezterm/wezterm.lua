-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.initial_rows = 100
config.initial_cols = 300

-- For example, changing the color scheme:
config.color_scheme = "catppuccin-mocha"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.font_size = 16.5
config.adjust_window_size_when_changing_font_size = false

config.default_cursor_style = "SteadyBar"
config.max_fps = 120

-- Cursor
-- config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local function split_nav(resize_or_move, key)
	local modifiers = resize_or_move == "resize" and "META|CTRL|SHIFT" or "CTRL|SHIFT"
	local direction = string.gsub(key, "Arrow", "")
	local act = resize_or_move == "resize" and { AdjustPaneSize = { direction, 3 } }
		or { ActivatePaneDirection = direction }
	return {
		key = key,
		mods = modifiers,
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				win:perform_action({ SendKey = { key = key, mods = modifiers } }, pane)
			else
				win:perform_action(act, pane)
			end
		end),
	}
end

config.keys = {
	split_nav("move", "LeftArrow"),
	split_nav("move", "DownArrow"),
	split_nav("move", "UpArrow"),
	split_nav("move", "RightArrow"),
	split_nav("resize", "LeftArrow"),
	split_nav("resize", "DownArrow"),
	split_nav("resize", "UpArrow"),
	split_nav("resize", "RightArrow"),
}

-- and finally, return the configuration to wezterm
return config

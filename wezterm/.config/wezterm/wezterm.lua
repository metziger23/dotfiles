-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.initial_rows = 100
config.initial_cols = 300

-- For example, changing the color scheme:
config.color_scheme = 'catppuccin-mocha'
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.font_size = 16.5
config.adjust_window_size_when_changing_font_size = false

config.default_cursor_style = 'SteadyBar'
config.max_fps = 120

-- Cursor
-- config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }

-- and finally, return the configuration to wezterm
return config

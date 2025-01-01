-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- For example, changing the color scheme:
config.color_scheme = 'catppuccin-mocha'

config.use_fancy_tab_bar = false

config.font_size = 18
config.adjust_window_size_when_changing_font_size = false

config.default_cursor_style = 'SteadyBar'
config.max_fps = 120
config.hide_tab_bar_if_only_one_tab = true

-- Cursor
-- config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true

-- and finally, return the configuration to wezterm
return config

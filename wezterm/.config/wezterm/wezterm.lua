-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
-- you can put the rest of your Wezterm config here
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { 'h', 'j', 'k', 'l' },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = 'CTRL', -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = 'META', -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})

-- This is where you actually apply your config choices

config.animation_fps = 10

-- For example, changing the color scheme:
config.color_scheme = 'catppuccin-mocha'

config.use_fancy_tab_bar = false

config.font_size = 18
-- config.window_background_opacity = 0.8
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"

-- Cursor
-- config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true

-- and finally, return the configuration to wezterm
return config

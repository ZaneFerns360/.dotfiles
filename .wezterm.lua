local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("JetBrains Mono Nerd Font")
config.font_size = 13
config.enable_tab_bar = false
config.window_decorations = "NONE"
config.window_background_opacity = 0.85
config.initial_rows = 45
config.initial_cols = 192

config.window_padding = {
	left = 0,
	right = 0,
	top = 2,
	bottom = 5,
}

return config

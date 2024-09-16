local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("JetBrains Mono Nerd Font")
config.font_size = 13
config.enable_tab_bar = false
config.window_decorations = "NONE"
config.window_background_opacity = 0.85
config.initial_rows = 45
config.initial_cols = 192
config.text_background_opacity = 1
config.bold_brightens_ansi_colors = true

config.foreground_text_hsb = {
	hue = 1,
	saturation = 1.1,
	brightness = 1.5,
}

config.colors = {
	cursor_bg = "#F8F8F2",
	cursor_border = "#F8F8F2",
	cursor_fg = "#011423",
	selection_bg = "#44475A",
	selection_fg = "#F8F8F2",
	ansi = {
		"#000000", -- Black
		"#cc0403", -- Red
		"#19cb00", -- Green
		"#cecb00", -- Yellow
		"#0d73cc", -- Blue
		"#cb1ed1", -- Magenta
		"#0dcdcd", -- Cyan
		"#dddddd", -- White
	},
	brights = {
		"#767676", -- Bright Black (Gray)
		"#f2201f", -- Bright Red
		"#23fd00", -- Bright Green
		"#fffd00", -- Bright Yellow
		"#1a8fff", -- Bright Blue
		"#fd28ff", -- Bright Magenta
		"#14ffff", -- Bright Cyan
		"#ffffff", -- Bright White
	},
}

config.window_padding = {
	left = 0,
	right = 0,
	top = 2,
	bottom = 5,
}

return config

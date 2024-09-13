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

config.colors = {
	cursor_bg = "#F8F8F2",
	cursor_border = "#F8F8F2",
	cursor_fg = "#011423",
	selection_bg = "#44475A",
	selection_fg = "#F8F8F2",
	ansi = {
		"#000000", -- Black
		"#cb0302", -- Red
		"#18ca00", -- Green
		"#cdca00", -- Yellow
		"#0c72cb", -- Blue
		"#ca1dd0", -- Purple (Magenta)
		"#0ccccc", -- Cyan
		"#dddddd", -- White
	},
	brights = {
		"#757575", -- Bright Black (Gray)
		"#f21f1e", -- Bright Red
		"#22fd00", -- Bright Green
		"#fffd00", -- Bright Yellow
		"#198fff", -- Bright Blue
		"#fd27ff", -- Bright Purple
		"#13ffff", -- Bright Cyan
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

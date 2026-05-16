------------------
---- MONITORS ----
------------------

hl.monitor({
	output = "",
	mode = "1920x1200@60.02",
	position = "auto",
	scale = "1",
})

hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 1.5, mirror = "eDP-1" })

hl.on("hyprland.start", function()
	hl.exec_cmd(
		"sleep 1; "
			.. "killall xdg-desktop-portal-hyprland; "
			.. "killall xdg-desktop-portal-wlr; "
			.. "killall xdg-desktop-portal"
	)

	hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland &")
	hl.exec_cmd("sleep 2; /usr/lib/xdg-desktop-portal &")

	hl.exec_cmd("nmcli radio wifi on")
	--hl.exec_cmd("nm-applet --indicator &")

	hl.exec_cmd("wl-paste --type text --watch cliphist store &")
	hl.exec_cmd("wl-paste --type image --watch cliphist store &")

	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme BreezeX-RosePine-Linux")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 28")

	hl.exec_cmd("brightnessctl set 25%")
end)

for i = 1, 8 do
	hl.workspace_rule({
		workspace = "name:" .. i,
		monitor = "DP-1",
		decorate = true,
		persistent = true,
	})
end

for i = 1, 8 do
	hl.exec_cmd("hyprctl dispatch 'hl.dsp.focus({ workspace = \"" .. i .. "\" })'")
end

hl.exec_cmd("hyprctl dispatch 'hl.dsp.focus({ workspace = \"1\" })'")

hl.config({

	general = {
		gaps_out = 15,

		border_size = 2,

		col = {
			active_border = "rgb(142353)",
			inactive_border = "rgb(142353)",
		},

		extend_border_grab_area = 20,
		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,
		layout = "dwindle",
	},
	ecosystem = { enforce_permissions = false },
	dwindle = {
		force_split = 0,
		preserve_split = true,
		smart_split = true,
		smart_resizing = true,
		permanent_direction_override = false,
		special_scale_factor = 1,
		split_width_multiplier = 1.0,
		use_active_for_splits = true,
		default_split_ratio = 1.0,
		split_bias = 0,
		precise_mouse_move = false,
	},
	decoration = {
		rounding = 10,
	},

	animations = {
		enabled = false,
	},
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			natural_scroll = true,
			middle_button_emulation = true,
		},
	},
})

--local SUPER = "SUPER"

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.bind("SUPER + P", hl.dsp.exec_cmd("~/.config/rofi/cliphist/run"))

hl.bind("Print", hl.dsp.exec_cmd("zsh ~/.config/hypr/scripts/region_screenshot.sh"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd("zsh ~/.config/hypr/scripts/fullscreen_screenshot.sh"))

hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("swaync-client --hide-latest"))

hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd("rofi -show drun || pkill rofi"))

hl.bind("SUPER + M", hl.dsp.exec_cmd("rofimoji --action copy --clipboarder wl-copy"))

hl.bind("SUPER + BACKSPACE", hl.dsp.exec_cmd("zen-browser"))
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("ghostty"))

hl.bind("SUPER + Q", hl.dsp.window.kill())
hl.bind("ALT + F4", hl.dsp.window.kill())

hl.bind("SUPER + O", hl.dsp.window.pseudo())
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + T", hl.dsp.layout("togglesplit")) -- dwindle only

hl.bind("SUPER + I", hl.dsp.exec_cmd("uwsm stop"))
hl.bind("SUPER + S", hl.dsp.exec_cmd("shutdown now"))
hl.bind("SUPER + R", hl.dsp.exec_cmd("reboot"))

hl.bind("xf86Launch1", hl.dsp.exec_cmd("zen-browser"))
hl.bind("KP_End", hl.dsp.exec_cmd("ghostty"))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + P", hl.dsp.window.pseudo())

hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + H", hl.dsp.window.move({ direction = "left", group_aware = false }))
hl.bind("ALT + J", hl.dsp.window.move({ direction = "down", group_aware = false }))
hl.bind("ALT + K", hl.dsp.window.move({ direction = "up", group_aware = false }))
hl.bind("ALT + L", hl.dsp.window.move({ direction = "right", group_aware = false }))

hl.bind("SUPER + SHIFT + L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))

-- Switch workspaces with SUPER + [0-9]
-- Move active window to a workspace with SUPER + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ match = { namespace = "rofi" }, animation = "popin" })

hl.env("TERMINAL", "ghostty")

-- XDG Specifications
-- hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
-- hl.env("XDG_SESSION_TYPE", "wayland")
-- hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_MENU_PREFIX", "arch-")
-- hl.env("GTK_THEME", "Breeze-Dark")

-- Toolkit Backend
hl.env("GDK_BACKEND", "wayland") -- use x11 when Wayland not available
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- Cursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")

-- Qt
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
-- hl.env("QT_STYLE_OVERRIDE", "kvantum")

-- NVIDIA
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("NVD_BACKEND", "direct")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")

-- Firefox
hl.env("MOZ_ENABLE_WAYLAND", "1")

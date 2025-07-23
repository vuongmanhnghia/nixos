local wezterm = require("wezterm")
local config = wezterm.config_builder()
local io = require("io")
local brightness = 0.08

-- === SHELL AND PROCESS CONFIGURATION ===
config.default_prog = { "zsh", "-l" }  -- Use ZSH for Powerlevel10k

-- === BACKGROUND IMAGE SYSTEM ===
local home = os.getenv("HOME")
local background_folder = home .. "/.config/wezterm/bg"

local function pick_random_background(folder)
	local handle = io.popen('ls "' .. folder .. '"')
	if handle ~= nil then
		local files = handle:read("*a")
		handle:close()
		local images = {}
		for file in string.gmatch(files, "[^\n]+") do
			table.insert(images, file)
		end
		if #images > 0 then
			return folder .. "/" .. images[math.random(#images)]
		end
	end
	return nil
end

local bg_image = background_folder .. "/bg.png"
config.window_background_image = bg_image
config.window_background_image_hsb = {
	brightness = brightness,
	hue = 1.0,
	saturation = 0.8,
}

-- === APPEARANCE ===
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
	{ family = "RobotoMono Nerd Font", weight = "Regular" },
	{ family = "Roboto Mono", weight = "Regular" },
	{ family = "Inter", weight = "Regular" },
	{ family = "MesloLGS Nerd Font", weight = "Regular" },
	{ family = "JetBrainsMono Nerd Font", weight = "Regular" },
	{ family = "Inconsolata Nerd Font Mono", weight = "Regular" },
	{ family = "Noto Sans", weight = "Regular" },
	{ family = "Noto Sans Symbols", weight = "Regular" },
	{ family = "Noto Color Emoji", weight = "Regular" },
	{ family = "Symbols Nerd Font", weight = "Regular" },
	{ family = "Font Awesome 6 Free", weight = "Regular" },
	{ family = "Liberation Mono", weight = "Regular" },
})
config.font_size = 14.0
config.line_height = 1.15  -- Better line spacing for icons
config.default_cursor_style = "BlinkingUnderline"
config.cursor_thickness = 2

-- === WINDOW SETTINGS ===
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20
config.window_decorations = "NONE"
config.enable_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.initial_rows = 24
config.initial_cols = 80
config.native_macos_fullscreen_mode = false
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- === TRANSPARENT BORDERS ===
config.window_frame = {
	border_left_width = "0.5cell",
	border_right_width = "0.5cell",
	border_bottom_height = "0.25cell",
	border_top_height = "0.25cell",
	border_left_color = "rgba(122, 162, 247, 0.0)",
	border_right_color = "rgba(187, 154, 247, 0.0)", 
	border_bottom_color = "rgba(125, 207, 255, 0.0)",
	border_top_color = "rgba(158, 206, 106, 0.0)",
}

-- === PERFORMANCE ===
config.animation_fps = 60
config.max_fps = 60
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- === KEY BINDINGS ===
config.keys = {
	{ key = "b", mods = "CTRL|SHIFT", action = wezterm.action_callback(function(window)
		bg_image = pick_random_background(background_folder)
		if bg_image then
			window:set_config_overrides({ window_background_image = bg_image })
		end
	end) },
	
	{ key = "L", mods = "CTRL|SHIFT", action = wezterm.action.OpenLinkAtMouseCursor },
	{ key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },
	{ key = "Enter", mods = "ALT", action = wezterm.action.ToggleFullScreen },
	{ key = "m", mods = "CTRL|SHIFT", action = wezterm.action_callback(function(window)
		window:maximize()
	end) },
	
	{ key = ">", mods = "CTRL|SHIFT", action = wezterm.action_callback(function(window)
		brightness = math.min(brightness + 0.01, 1.0)
		window:set_config_overrides({
			window_background_image_hsb = { brightness = brightness, hue = 1.0, saturation = 0.8 },
			window_background_image = bg_image,
		})
	end) },
	
	{ key = "<", mods = "CTRL|SHIFT", action = wezterm.action_callback(function(window)
		brightness = math.max(brightness - 0.01, 0.01)
		window:set_config_overrides({
			window_background_image_hsb = { brightness = brightness, hue = 1.0, saturation = 0.8 },
			window_background_image = bg_image,
		})
	end) },
}

-- === AUTO-STARTUP ===
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config

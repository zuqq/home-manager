local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = "Tokyo Night"
config.font = wezterm.font("SF Mono")
config.font_size = 13.0
return config

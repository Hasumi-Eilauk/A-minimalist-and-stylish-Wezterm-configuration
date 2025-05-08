local wezterm = require("wezterm")
local platform = require("utils.platform")

return {
	font = wezterm.font("DejaVuSansM Nerd Font Propo"),
	font_size = 13,

	freetype_load_target = "Normal",
	freetype_render_target = "Normal",

	font_size = platform().is_mac and 12 or 13,
}

---------------------------------------------------------------------
-- wezterm终端字体配置                                             --
-- 作者:忘羽梦汐                                                   --
-- 功能介绍:这个代码是WezTerm终端的字体设置，字体渲染，字体大小等  --
---------------------------------------------------------------------

local wezterm = require("wezterm")
local platform = require("utils.platform")

return {
	-- 设置终端字体为 DejaVuSansM Nerd Font Propo，支持丰富图标和符号
	font = wezterm.font("DejaVuSansM Nerd Font Propo"),

	-- 根据操作系统动态设置字体大小：
	-- macOS 下字体稍小（12），其他平台使用默认字体大小（13）
	font_size = platform().is_mac and 12 or 13,

	-- FreeType 字体加载渲染参数
	-- "Normal" 表示常规的字体加载目标，平衡性能和质量
	freetype_load_target = "Normal",

	-- FreeType 字体渲染目标，同样设置为 "Normal"
	freetype_render_target = "Normal",
}

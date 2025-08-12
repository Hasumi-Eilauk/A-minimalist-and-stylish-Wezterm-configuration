---------------------------------------------------------------------
-- 标签栏按键配置                                                  --
-- 作者:忘羽梦汐                                                   --
-- 功能介绍:这个代码是终端的按键点击配置                           --
---------------------------------------------------------------------

local wezterm = require("wezterm")

local M = {}

--- 设置 WezTerm 新建标签按钮的点击行为
-- 左键：执行默认的新建标签操作
-- 右键：打开一个带搜索功能的启动器（快速选择/搜索菜单）
M.setup = function()
	wezterm.on("new-tab-button-click", function(window, pane, button, default_action)
		-- 调试日志（可在 WezTerm 日志中查看点击事件信息）
		wezterm.log_info("new-tab-button-click", button, default_action)

		-- 如果没有默认动作，则直接返回，不做任何处理
		if not default_action then
			return false
		end

		if button == "Left" then
			-- 左键点击：执行 WezTerm 默认的新建标签动作
			window:perform_action(default_action, pane)
		elseif button == "Right" then
			-- 右键点击：显示带模糊搜索的启动器
			window:perform_action(
				wezterm.action.ShowLauncherArgs({
					title = "🗂  快速选择/搜索",
					flags = "FUZZY|LAUNCH_MENU_ITEMS|DOMAINS", -- 模糊匹配 + 启动菜单 + 远程域
				}),
				pane
			)
		end

		-- 返回 false 表示事件已处理，但允许 WezTerm 继续处理默认逻辑
		return false
	end)
end

return M

---------------------------------------------------------------------
-- WezTerm 终端的右侧状态栏模块                                    --
-- 作者:忘羽梦汐                                                   --
-- 功能介绍:这个代码是用于美化wezterm的右侧状态,显示时间等功能     --
---------------------------------------------------------------------
-- 注意!台式机不会显示电池，只有笔记本电脑会在当前终端显示电池电量！！

local wezterm = require("wezterm")
local math = require("utils.math")
local M = {}
M.separator_char = " ~ "

-- 各类状态项的前景色（文字颜色）和背景色
M.colors = {
	date_fg = "#3E7FB5", -- 日期文字颜色
	date_bg = "#0F2536", -- 日期背景颜色
	battery_fg = "#B52F90", -- 电量文字颜色
	battery_bg = "#0F2536", -- 电量背景颜色
	separator_fg = "#786D22", -- 分隔符文字颜色
	separator_bg = "#0F2536", -- 分隔符背景颜色
}
-- ========================
-- 状态栏渲染数据
-- ========================

-- 存储状态栏单元格的格式化数据（wezterm.format 格式）
M.cells = {}

--- 往状态栏右侧追加一个状态单元格
---@param text string  要显示的文字（例如时间、电量百分比）
---@param icon string  状态前的图标（例如 ⏰、电池图标）
---@param fg string    文字颜色
---@param bg string    背景颜色
---@param separate boolean 是否在该单元格后添加分隔符
local function push_cell(text, icon, fg, bg, separate)
	-- 设置前景色
	table.insert(M.cells, { Foreground = { Color = fg } })
	-- 设置背景色
	table.insert(M.cells, { Background = { Color = bg } })
	-- 设置文字样式为粗体
	table.insert(M.cells, { Attribute = { Intensity = "Bold" } })
	-- 添加图标 + 空格 + 文字 + 尾部空格
	table.insert(M.cells, { Text = string.format("%s %s ", icon, text) })

	-- 如果需要分隔符，则添加分隔符样式与字符
	if separate then
		table.insert(M.cells, { Foreground = { Color = M.colors.separator_fg } })
		table.insert(M.cells, { Background = { Color = M.colors.separator_bg } })
		table.insert(M.cells, { Text = M.separator_char })
	end

	-- 重置样式，避免影响后续单元格
	table.insert(M.cells, "ResetAttributes")
end

--- 设置日期时间状态
local function set_date()
	-- 获取当前日期与时间，格式为：Date:MM-DD | Time:HH:MM | 周几
	local date_str = wezterm.strftime("Date:%m-%d | Time:%H:%M | %a")
	-- 调用 push_cell 将日期加入状态栏，并添加分隔符
	push_cell(date_str, "⏰", M.colors.date_fg, M.colors.date_bg, true)
end

--- 设置电池状态
local function set_battery()
	-- 不同电量区间的放电图标（从低电量到高电量）
	local discharging_icons = { "󰂃", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹" }
	-- 不同电量区间的充电图标（从低电量到高电量）
	local charging_icons = { "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅" }

	-- 根据电量百分比与状态返回对应的图标
	local function get_icon(charge_ratio, state)
		-- 将电量（0.0~1.0）转为 1~10 的整数索引
		local idx = math.clamp(math.round(charge_ratio * 10), 1, 10)
		-- 如果正在充电，返回充电图标，否则返回放电图标
		return state == "Charging" and charging_icons[idx] or discharging_icons[idx]
	end

	-- 遍历所有电池（有些设备可能有多个电池）
	for _, b in ipairs(wezterm.battery_info()) do
		-- 将电量转为百分比字符串（不带小数）
		local charge_pct = string.format("%.0f%%", b.state_of_charge * 100)
		-- 获取对应的图标
		local icon = get_icon(b.state_of_charge, b.state)
		-- 添加到状态栏，不需要分隔符（因为是最后一个）
		push_cell(charge_pct, icon, M.colors.battery_fg, M.colors.battery_bg, false)
	end
end

--- 初始化模块
M.setup = function()
	-- 注册 WezTerm 事件，每次状态栏需要更新时触发
	wezterm.on("update-right-status", function(window, _)
		-- 清空之前的单元格
		M.cells = {}
		-- 依次添加日期和电池状态
		set_date()
		set_battery()
		-- 将格式化后的单元格应用到右侧状态栏
		window:set_right_status(wezterm.format(M.cells))
	end)
end

-- 返回模块
return M

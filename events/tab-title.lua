---------------------------------------------------------------------
-- 标签栏配置                                                        --
-- 作者:忘羽梦汐                                                     --
-- 功能介绍:这个代码是WezTerm终端Lua配置模块,用来美化WezTerm标签栏        --
---------------------------------------------------------------------

-- 引入 wezterm API
local wezterm = require("wezterm")

-- 图标定义（使用 Nerd Font 图标，渲染 tab 栏的装饰）
local ICONS = {
        LEFT = "",
        RIGHT = "",
        CIRCLE = "󰇷 ",
        ADMIN = "󰖳 ",
}

-- 颜色主题配置
local COLORS = {
        default = { bg = "#8C246F", fg = "#0F2536" }, -- 默认标签背景/前景色
        active = { bg = "#3A854B", fg = "#0F2536" }, -- 活动标签背景/前景色
        hover = { bg = "#8C246F", fg = "#0F2536" }, -- 鼠标悬停时背景/前景色
        alert = "#FF3B8B", -- 未读输出提示颜色
}

local M = {}
M.cells = {} -- 用于存放标签栏绘制的所有单元格（WezTerm 会按顺序绘制）

---------------------------------------------------
-- push: 向标签绘制队列添加一段带样式的文本
-- @param bg 背景颜色
-- @param fg 前景颜色
-- @param attr 样式表（例如 { Intensity = "Bold" }）
-- @param text 要绘制的文字/图标
---------------------------------------------------
local function push(bg, fg, attr, text)
        table.insert(M.cells, { Background = { Color = bg } }) -- 背景色
        table.insert(M.cells, { Foreground = { Color = fg } }) -- 前景色
        table.insert(M.cells, { Attribute = attr }) -- 样式（加粗等）
        table.insert(M.cells, { Text = text }) -- 文本内容
end

---------------------------------------------------
-- short_process_name: 从进程路径提取短名（去掉目录和 .exe 后缀）
-- 例："/usr/bin/bash" -> "bash"
--      "C:\\Windows\\cmd.exe" -> "cmd"
---------------------------------------------------
local function short_process_name(path)
        return path:gsub("(.*[/\\])", ""):gsub("%.exe$", "")
end

---------------------------------------------------
-- format_title: 生成标签标题
-- @param process 当前进程名
-- @param static  用户手动设置的标签名
-- @param active  当前面板的窗口标题
-- @param max_width 标签最大宽度（WezTerm 传入）
-- @param inset 标题左右的保留空位
--
-- 标题生成规则：
-- 1. 有进程名且没有手动标题 -> 显示进程名
-- 2. 有手动标题 -> 显示手动标题
-- 3. 其他情况 -> 显示当前面板标题
-- 超出 max_width 会自动截断
---------------------------------------------------
local function format_title(process, static, active, max_width, inset)
        local title
        inset = inset or 6 -- 默认左右留 6 字宽的空间

        if #process > 0 and #static == 0 then
                title = string.format("󰌽  %s ~ ", process)
        elseif #static > 0 then
                title = string.format("󰌽 %s ~ ", static)
        else
                title = string.format("󰌽  %s ~ ", active)
        end

        -- 如果标题过长则截断
        if #title > max_width - inset then
                local diff = #title - max_width + inset
                title = wezterm.truncate_right(title, #title - diff)
        end
        return title
end

---------------------------------------------------
-- is_admin: 判断窗口标题是否包含“Administrator: ”前缀
-- 主要用于检测在 Windows 下是否为管理员终端
---------------------------------------------------
local function is_admin(title)
        return title:match("^Administrator: ") ~= nil
end

---------------------------------------------------
-- has_unseen: 检查标签内的所有面板是否有未读输出
-- 只要有一个 pane.has_unseen_output == true 就返回 true
---------------------------------------------------
local function has_unseen(tab)
        for _, pane in ipairs(tab.panes) do
                if pane.has_unseen_output then
                        return true
                end
        end
        return false
end

---------------------------------------------------
-- get_colors: 根据标签状态（活动/悬停/默认）返回对应的背景和前景颜色
---------------------------------------------------
local function get_colors(tab, hover)
        if tab.is_active then
                return COLORS.active.bg, COLORS.active.fg
        elseif hover then
                return COLORS.hover.bg, COLORS.hover.fg
        else
                return COLORS.default.bg, COLORS.default.fg
        end
end

---------------------------------------------------
-- M.setup: 主入口，注册 wezterm "format-tab-title" 事件
-- WezTerm 在绘制每个标签时都会调用这个回调
---------------------------------------------------
M.setup = function()
        wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
                M.cells = {} -- 清空绘制队列

                -- 处理标签的关键信息
                local process = short_process_name(tab.active_pane.foreground_process_name) -- 提取进程名
                local admin_flag = is_admin(tab.active_pane.title) -- 是否为管理员终端
                local title = format_title(process, tab.tab_title, tab.active_pane.title, max_width, admin_flag and 8) -- 生成标题
                local bg, fg = get_colors(tab, hover) -- 获取颜色方案
                local unseen_flag = has_unseen(tab) -- 是否有未读输出

                -- 左半圆分隔符（作为标签起始装饰）
                push(fg, bg, { Intensity = "Bold" }, ICONS.LEFT)

                -- 管理员图标（如果是管理员终端）
                if admin_flag then
                        push(bg, fg, { Intensity = "Bold" }, " " .. ICONS.ADMIN)
                end

                -- 标签标题
                push(bg, fg, { Intensity = "Bold" }, " " .. title)

                -- 未读输出提示（红色圆点）
                if unseen_flag then
                        push(bg, COLORS.alert, { Intensity = "Bold" }, " " .. ICONS.CIRCLE)
                end

                -- 标签右侧空格和右半圆收尾
                push(bg, fg, { Intensity = "Bold" }, " ")
                push(fg, bg, { Intensity = "Bold" }, ICONS.RIGHT)

                -- 返回绘制队列给 wezterm
                return M.cells
        end)
end

return M

---------------------------------------------------------------------
-- wezterm快捷键                                                   --
-- 作者:忘羽梦汐                                                   --
-- 功能介绍:这个代码是wezterm 内置的快捷键动作集合                 --
---------------------------------------------------------------------

local wezterm = require("wezterm")
local platform = require("utils.platform")() -- 自定义平台检测模块，返回当前操作系统信息
local act = wezterm.action -- wezterm 内置的快捷键动作集合

local mod = {}

-- 根据平台设置超级键(SUPER)的定义，方便跨平台统一快捷键写法
if platform.is_mac then
        mod.SUPER = "SUPER" -- macOS 上使用 Command 键
        mod.SUPER_REV = "SUPER|CTRL" -- Command + Ctrl 作为扩展快捷键组合
elseif platform.is_win or platform.is_linux then
        mod.SUPER = "ALT" -- Windows 和 Linux 上用 Alt 键，避免与 Win 键冲突
        mod.SUPER_REV = "ALT|CTRL" -- Alt + Ctrl 作为扩展快捷键组合
end

-- 辅助函数，简化快捷键绑定写法
local function keybind(key, mods, action)
        return { key = key, mods = mods, action = action }
end

local keys = {
        -- ===== 杂项功能 =====
        keybind("F1", "NONE", "ActivateCopyMode"), -- F1 进入复制模式（类似 vim 的视觉选择）
        keybind("F2", "NONE", act.ActivateCommandPalette), -- F2 打开命令面板
        keybind("F3", "NONE", act.ShowLauncher), -- F3 显示启动器
        keybind("F4", "NONE", act.ShowTabNavigator), -- F4 标签页导航
        keybind("F11", "NONE", act.ToggleFullScreen), -- F11 切换全屏
        keybind("F12", "NONE", act.ShowDebugOverlay), -- F12 显示调试覆盖层
        keybind("f", mod.SUPER, act.Search({ CaseInSensitiveString = "" })), -- SUPER+f 调出搜索（大小写不敏感）

        -- ===== 复制粘贴 =====
        keybind("c", "CTRL|SHIFT", act.CopyTo("Clipboard")), -- Ctrl+Shift+c 复制到剪贴板
        keybind("v", "CTRL|SHIFT", act.PasteFrom("Clipboard")), -- Ctrl+Shift+v 从剪贴板粘贴

        -- ===== 标签操作 =====
        keybind("t", mod.SUPER, act.SpawnTab("DefaultDomain")), -- SUPER+t 新建标签页（默认域）
        keybind("t", mod.SUPER_REV, act.SpawnTab({ DomainName = "WSL:Ubuntu" })), -- SUPER+CTRL+t 新建WSL Ubuntu标签页
        keybind("w", mod.SUPER_REV, act.CloseCurrentTab({ confirm = false })), -- SUPER+CTRL+w 关闭当前标签（无提示）

        -- ===== 标签导航和移动 =====
        keybind("[", mod.SUPER, act.ActivateTabRelative(-1)), -- SUPER+[ 激活左边的标签
        keybind("]", mod.SUPER, act.ActivateTabRelative(1)), -- SUPER+] 激活右边的标签
        keybind("[", mod.SUPER_REV, act.MoveTabRelative(-1)), -- SUPER+CTRL+[ 将当前标签左移
        keybind("]", mod.SUPER_REV, act.MoveTabRelative(1)), -- SUPER+CTRL+] 将当前标签右移

        -- ===== 窗口操作 =====
        keybind("n", mod.SUPER, act.SpawnWindow), -- SUPER+n 新建一个窗口

        -- ===== 分屏操作 =====
        keybind("/", mod.SUPER_REV, act.SplitVertical({ domain = "CurrentPaneDomain" })), -- SUPER+CTRL+/ 垂直分屏
        keybind("\\", mod.SUPER_REV, act.SplitHorizontal({ domain = "CurrentPaneDomain" })), -- SUPER+CTRL+\ 水平分屏
        keybind("-", mod.SUPER_REV, act.CloseCurrentPane({ confirm = true })), -- SUPER+CTRL+- 关闭当前面板（有确认）

        keybind("z", mod.SUPER_REV, act.TogglePaneZoomState), -- SUPER+CTRL+z 面板放大/恢复
        keybind("w", mod.SUPER, act.CloseCurrentPane({ confirm = false })), -- SUPER+w 关闭当前面板（无确认）

        -- ===== 分屏导航 =====
        keybind("k", mod.SUPER_REV, act.ActivatePaneDirection("Up")), -- SUPER+CTRL+k 激活上方面板
        keybind("j", mod.SUPER_REV, act.ActivatePaneDirection("Down")), -- SUPER+CTRL+j 激活下方面板
        keybind("h", mod.SUPER_REV, act.ActivatePaneDirection("Left")), -- SUPER+CTRL+h 激活左边面板
        keybind("l", mod.SUPER_REV, act.ActivatePaneDirection("Right")), -- SUPER+CTRL+l 激活右边面板

        -- ===== 调整分屏大小 =====
        keybind("UpArrow", mod.SUPER_REV, act.AdjustPaneSize({ "Up", 1 })), -- SUPER+CTRL+上箭头 调整面板大小
        keybind("DownArrow", mod.SUPER_REV, act.AdjustPaneSize({ "Down", 1 })),
        keybind("LeftArrow", mod.SUPER_REV, act.AdjustPaneSize({ "Left", 1 })),
        keybind("RightArrow", mod.SUPER_REV, act.AdjustPaneSize({ "Right", 1 })),

        -- ===== 字体大小调整 =====
        keybind("UpArrow", mod.SUPER, act.IncreaseFontSize), -- SUPER+上箭头 放大字体
        keybind("DownArrow", mod.SUPER, act.DecreaseFontSize), -- SUPER+下箭头 缩小字体
        keybind("r", mod.SUPER, act.ResetFontSize), -- SUPER+r 重置字体大小

        -- ===== 激活键表 (key tables) =====
        {
                key = "f",
                mods = "LEADER",
                action = act.ActivateKeyTable({
                        name = "resize_font", -- 进入字体大小调整模式
                        one_shot = false, -- 持续激活，直到手动退出
                        timeout_milliseconds = 1000, -- 超时1秒自动退出
                }),
        },
        {
                key = "p",
                mods = "LEADER",
                action = act.ActivateKeyTable({
                        name = "resize_pane", -- 进入面板大小调整模式
                        one_shot = false,
                        timeout_milliseconds = 1000,
                }),
        },

        -- ===== 重命名标签 =====
        {
                key = "R",
                mods = "CTRL|SHIFT",
                action = act.PromptInputLine({
                        description = "Enter new name for tab", -- 弹出输入框提示
                        action = wezterm.action_callback(function(window, pane, line)
                                -- line: 输入的文本，nil 表示取消，空字符串表示清空标题
                                if line then
                                        window:active_tab():set_title(line) -- 设置当前标签标题
                                end
                        end),
                }),
        },
}

local key_tables = {
        -- 字体调整键表，方便在激活后通过单键调整字体大小
        resize_font = {
                keybind("k", nil, act.IncreaseFontSize),
                keybind("j", nil, act.DecreaseFontSize),
                keybind("r", nil, act.ResetFontSize),
                keybind("Escape", nil, "PopKeyTable"), -- 退出键表
                keybind("q", nil, "PopKeyTable"),
        },
        -- 面板调整键表，激活后通过hjkl调整面板大小
        resize_pane = {
                keybind("k", nil, act.AdjustPaneSize({ "Up", 1 })),
                keybind("j", nil, act.AdjustPaneSize({ "Down", 1 })),
                keybind("h", nil, act.AdjustPaneSize({ "Left", 1 })),
                keybind("l", nil, act.AdjustPaneSize({ "Right", 1 })),
                keybind("Escape", nil, "PopKeyTable"),
                keybind("q", nil, "PopKeyTable"),
        },
}

local mouse_bindings = {
        -- Ctrl + 左键单击：打开链接
        {
                event = { Up = { streak = 1, button = "Left" } },
                mods = "CTRL",
                action = act.OpenLinkAtMouseCursor,
        },
        -- 鼠标左键点击和拖动文本选择，选中单元格(Cell)
        {
                event = { Down = { streak = 1, button = "Left" } },
                mods = "NONE",
                action = act.SelectTextAtMouseCursor("Cell"),
        },
        {
                event = { Up = { streak = 1, button = "Left" } },
                mods = "NONE",
                action = act.ExtendSelectionToMouseCursor("Cell"),
        },
        {
                event = { Drag = { streak = 1, button = "Left" } },
                mods = "NONE",
                action = act.ExtendSelectionToMouseCursor("Cell"),
        },
        -- 三击选中整行
        {
                event = { Down = { streak = 3, button = "Left" } },
                mods = "NONE",
                action = act.SelectTextAtMouseCursor("Line"),
        },
        {
                event = { Up = { streak = 3, button = "Left" } },
                mods = "NONE",
                action = act.SelectTextAtMouseCursor("Line"),
        },
        -- 双击选中单词
        {
                event = { Down = { streak = 2, button = "Left" } },
                mods = "NONE",
                action = act.SelectTextAtMouseCursor("Word"),
        },
        {
                event = { Up = { streak = 2, button = "Left" } },
                mods = "NONE",
                action = act.SelectTextAtMouseCursor("Word"),
        },
        -- 鼠标滚轮上下滚动终端内容
        {
                event = { Down = { streak = 1, button = { WheelUp = 1 } } },
                mods = "NONE",
                action = act.ScrollByCurrentEventWheelDelta,
        },
        {
                event = { Down = { streak = 1, button = { WheelDown = 1 } } },
                mods = "NONE",
                action = act.ScrollByCurrentEventWheelDelta,
        },
}

return {
        disable_default_key_bindings = true, -- 禁用 wezterm 默认快捷键，使用自定义的
        disable_default_mouse_bindings = true, -- 禁用默认鼠标绑定
        leader = { key = "Space", mods = "CTRL|SHIFT" }, -- 设定 leader 键为 Ctrl+Shift+Space
        keys = keys,
        key_tables = key_tables,
        mouse_bindings = mouse_bindings,
}

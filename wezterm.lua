---------------------------------------------------------------------
-- 外观配色                                                        --
-- 作者:忘羽梦汐                                                   --
-- 功能介绍:配色方案设置，光标设置i，鼠标逻辑                      --
---------------------------------------------------------------------

-- 导入必要的模块
-- config 模块：管理配置的基类
local Config = require("config")
-- wezterm 模块：提供终端API和功能
local wezterm = require("wezterm")

-- 初始化事件处理模块
-- 右侧状态栏事件处理
require("events.right-status").setup()
-- 标签标题格式化事件处理
require("events.tab-title").setup()
-- 新建标签按钮事件处理
require("events.new-tab-button").setup()

-- 定义颜色方案常量
-- 使用分层结构组织颜色配置，便于维护和修改
local COLOR_SCHEME = {
        -- 基础颜色配置
        BASE = {
                foreground = "#FFFFFF",
                background = "#1a1b26",
        },

        -- 光标相关颜色
        CURSOR = {
                bg = "#32CD32", -- 光标背景色
                fg = "#1a1b26", -- 光标前景色
                border = "#c0caf5", -- 光标边框色
        },

        -- 文本选择区域颜色
        SELECTION = {
                fg = "#1a1b26", -- 选中文本颜色（深蓝色）
                bg = "#c0caf5", -- 选中背景色（淡蓝色）
        },

        -- 标签栏颜色配置
        TAB_BAR = {
                background = "#FFFF00", -- 标签栏背景色

                -- 活动标签样式
                active_tab = {
                        bg_color = "#FFFF00", -- 活动标签背景（中蓝色）
                        fg_color = "#7dcfff", -- 活动标签文字（亮蓝色）
                },

                -- 非活动标签样式
                inactive_tab = {
                        bg_color = "#1a1b26", -- 非活动标签背景
                        fg_color = "#565f89", -- 非活动标签文字（灰蓝色）
                },

                -- 鼠标悬停时的非活动标签样式
                inactive_tab_hover = {
                        bg_color = "#24283b", -- 悬停背景色
                        fg_color = "#7aa2f7", -- 悬停文字色
                },

                -- 新建标签按钮样式
                new_tab = {
                        bg_color = "#1a1b26", -- 默认背景
                        fg_color = "#c0caf5", -- 默认文字色
                },

                -- 鼠标悬停时的新建标签按钮样式
                new_tab_hover = {
                        bg_color = "#414868", -- 悬停背景
                        fg_color = "#7dcfff", -- 悬停文字
                },
        },

        -- 其他UI元素颜色
        UI = {
                scrollbar_thumb = "#414868", -- 滚动条颜色
                split = "#16161e", -- 分屏分隔线颜色
        },

        -- ANSI 16色模式的基础8色
        ANSI = {
                "#15161e", -- 黑色
                "#f7768e", -- 红色
                "#9ece6a", -- 绿色
                "#e0af68", -- 黄色
                "#7aa2f7", -- 蓝色
                "#bb9af7", -- 品红
                "#7dcfff", -- 青色
                "#a9b1d6", -- 白色
        },

        -- ANSI 16色模式的亮色
        BRIGHTS = {
                "#414868", -- 亮黑（灰）
                "#f7768e", -- 亮红
                "#9ece6a", -- 亮绿
                "#e0af68", -- 亮黄
                "#7aa2f7", -- 亮蓝
                "#bb9af7", -- 亮品红
                "#7dcfff", -- 亮青
                "#c0caf5", -- 亮白
        },
}

-- 构建基础配置
-- 使用链式调用依次加载各子模块配置
local base_config = Config
        :init()
        :append(require("config.appearance")) -- 外观配置
        :append(require("config.bindings")) -- 键位绑定
        :append(require("config.domains")) -- 域配置（WSL/SSH等）
        :append(require("config.fonts")) -- 字体配置
        :append(require("config.general")) -- 通用配置
        :append(require("config.launch"))
        .options -- 启动菜单配置

-- 应用颜色方案到基础配置
base_config.colors = {
        -- 基础颜色
        foreground = COLOR_SCHEME.BASE.foreground,
        background = COLOR_SCHEME.BASE.background,

        -- 光标设置
        cursor_bg = COLOR_SCHEME.CURSOR.bg,
        cursor_fg = COLOR_SCHEME.CURSOR.fg,
        cursor_border = COLOR_SCHEME.CURSOR.border,

        -- 文本选择设置
        selection_fg = COLOR_SCHEME.SELECTION.fg,
        selection_bg = COLOR_SCHEME.SELECTION.bg,

        -- 标签栏设置
        tab_bar = COLOR_SCHEME.TAB_BAR,

        -- 其他UI元素
        scrollbar_thumb = COLOR_SCHEME.UI.scrollbar_thumb,
        split = COLOR_SCHEME.UI.split,

        -- ANSI颜色
        ansi = COLOR_SCHEME.ANSI,
        brights = COLOR_SCHEME.BRIGHTS,
}

-- 添加鼠标右键粘贴功能
-- 初始化鼠标绑定表（如果不存在）
base_config.mouse_bindings = base_config.mouse_bindings or {}
-- 添加右键粘贴功能
table.insert(base_config.mouse_bindings, {
        event = { Up = { streak = 1, button = "Right" } }, -- 鼠标右键释放事件
        mods = "NONE", -- 不组合任何修饰键
        action = wezterm.action.PasteFrom("Clipboard"), -- 执行粘贴动作
})

-- 返回最终配置
return base_config

---------------------------------------------------------------------
-- 配色方案                                                        --
-- 作者:忘羽梦汐                                                   --
-- 功能介绍:主题的微调版配色方案                                   --
---------------------------------------------------------------------

local mocha = {
        rosewater = "#f5e0dc",
        flamingo = "#f2cdcd",
        pink = "#f5c2e7",
        mauve = "#cba6f7",
        red = "#f38ba8",
        maroon = "#eba0ac",
        peach = "#fab387",
        yellow = "#f9e2af",
        green = "#a6e3a1",
        teal = "#94e2d5",
        sky = "#89dceb",
        sapphire = "#74c7ec",
        blue = "#89b4fa",
        lavender = "#b4befe",
        text = "#cdd6f4",
        subtext1 = "#bac2de",
        subtext0 = "#a6adc8",
        overlay2 = "#9399b2",
        overlay1 = "#7f849c",
        overlay0 = "#6c7086",
        surface2 = "#585b70",
        surface1 = "#45475a",
        surface0 = "#313244",
        base = "#1f1f28",
        mantle = "#181825",
        crust = "#11111b",
}

local colorscheme = {
        -- 基础颜色
        foreground = mocha.text,
        background = mocha.base,

        -- 光标样式
        cursor_bg = mocha.rosewater,
        cursor_border = mocha.rosewater,
        cursor_fg = mocha.crust,

        -- 选择文本颜色
        selection_bg = mocha.surface2,
        selection_fg = mocha.text,

        -- ANSI 颜色（基础）
        ansi = {
                "#0C0C0C", -- black
                "#C50F1F", -- red
                "#13A10E", -- green
                "#C19C00", -- yellow
                "#0037DA", -- blue
                "#881798", -- magenta/purple
                "#3A96DD", -- cyan
                "#CCCCCC", -- white
        },

        -- ANSI 颜色（明亮）
        brights = {
                "#767676", -- black
                "#E74856", -- red
                "#16C60C", -- green
                "#F9F1A5", -- yellow
                "#3B78FF", -- blue
                "#B4009E", -- magenta/purple
                "#61D6D6", -- cyan
                "#F2F2F2", -- white
        },

        -- 标签栏颜色
        tab_bar = {
                background = "#000000",
                active_tab = { bg_color = mocha.surface2, fg_color = mocha.text },
                inactive_tab = { bg_color = mocha.surface0, fg_color = mocha.subtext1 },
                inactive_tab_hover = { bg_color = mocha.surface0, fg_color = mocha.text },
                new_tab = { bg_color = mocha.base, fg_color = mocha.text },
                new_tab_hover = { bg_color = mocha.mantle, fg_color = mocha.text, italic = true },
        },

        -- 视觉警告颜色（闪屏）
        visual_bell = mocha.surface0,

        -- 扩展索引颜色
        indexed = {
                [16] = mocha.peach,
                [17] = mocha.rosewater,
        },

        -- 滚动条滑块颜色
        scrollbar_thumb = mocha.surface2,

        -- 分割线颜色
        split = mocha.overlay0,

        -- 组合光标颜色（nightly 版本专用）
        compose_cursor = mocha.flamingo,
}

return colorscheme
╭─    ~/仓库/wezterm    main !11                                                                                             ✔  04:14:40  ─╮
╰─ cat config/appearance.lua                                                                                                                          ─╯
----------------------------------------------------------------------------------------
-- 终端美化配置                                                                       --
-- 作者:忘羽梦汐                                                                      --
-- 功能介绍:这个代码是WezTerm终端的窗口美化，终端字体，渲染，动画，背景配置，光标配置 --
----------------------------------------------------------------------------------------

local wezterm = require("wezterm")
local colors = require("colors.custom")
-- local fonts = require('config.fonts')

return {
        -- 终端仿真类型，支持 256 色
        term = "xterm-256color",

        -- 动画相关帧率设置
        animation_fps = 60, -- 动画每秒帧数
        max_fps = 60, -- 最大帧率限制

        -- 渲染相关配置
        front_end = "WebGpu", -- 使用 WebGPU 前端进行渲染（需要支持）
        webgpu_power_preference = "HighPerformance", -- 优先使用高性能 GPU

        -- 颜色方案设置（此处注释掉了自定义颜色，使用 Gruvbox 主题）
        -- colors = colors,
        color_scheme = "Gruvbox dark, medium (base16)",

        -- 背景设置
        window_background_opacity = 1.00, -- 窗口背景不透明度（1为完全不透明）
        win32_system_backdrop = "Acrylic", -- Windows 特有的半透明毛玻璃效果

        -- 背景渐变配置，线性渐变，角度为-45度
        window_background_gradient = {
                colors = { "#1D261B", "#261A25" },
                orientation = { Linear = { angle = -45.0 } },
        },

        -- 多层背景，第一层为图片，第二层为颜色覆盖（带透明度）
        background = {
                {
                        source = { File = wezterm.config_dir .. "/backdrops/astro-jelly.jpg" },
                },
                {
                        source = { Color = "#1A1B26" },
                        height = "100%",
                        width = "100%",
                        opacity = 0.95, -- 颜色覆盖层透明度
                },
        },

        -- 滚动条配置
        enable_scroll_bar = true, -- 启用滚动条
        min_scroll_bar_height = "3cell", -- 滚动条最小高度为3字符高度
        colors = {
                scrollbar_thumb = "#34354D", -- 滚动条滑块颜色
        },

        -- 标签栏配置
        enable_tab_bar = true, -- 启用标签栏
        hide_tab_bar_if_only_one_tab = false, -- 只有一个标签时不隐藏标签栏
        use_fancy_tab_bar = true, -- 启用花哨标签栏样式
        tab_max_width = 25, -- 标签最大宽度
        show_tab_index_in_tab_bar = true, -- 显示标签索引（序号）
        switch_to_last_active_tab_when_closing_tab = true, -- 关闭标签切换到上一个活跃标签

        -- 光标配置
        default_cursor_style = "BlinkingUnderline", -- 默认光标为闪烁下划线
        cursor_blink_ease_in = "Constant", -- 光标闪烁动画淡入效果
        cursor_blink_ease_out = "Constant", -- 光标闪烁动画淡出效果
        cursor_blink_rate = 700, -- 光标闪烁周期，单位毫秒

        -- 窗口配置
        adjust_window_size_when_changing_font_size = false, -- 调整字体大小时不自动调整窗口大小
        window_decorations = "INTEGRATED_BUTTONS|RESIZE", -- 窗口装饰，集成按钮和可调整大小
        integrated_title_button_style = "Windows", -- 标题栏按钮样式为 Windows 风格
        integrated_title_button_color = "auto", -- 标题栏按钮颜色自动
        integrated_title_button_alignment = "Right", -- 标题栏按钮靠右对齐

        -- 窗口初始大小
        initial_cols = 120, -- 初始列数
        initial_rows = 24, -- 初始行数

        -- 窗口内边距（单位为像素）
        window_padding = {
                left = 5,
                right = 10,
                top = 12,
                bottom = 7,
        },

        -- 关闭窗口时总是弹出确认提示
        window_close_confirmation = "AlwaysPrompt",

        -- 窗口框架颜色配置
        window_frame = {
                active_titlebar_bg = "#0F2536", -- 活动窗口标题栏背景色
                inactive_titlebar_bg = "#0F2536", -- 非活动窗口标题栏背景色
                -- font = fonts.font,               -- 标题栏字体（暂时注释）
                -- font_size = fonts.font_size,    -- 标题栏字体大小（暂时注释）
        },

        -- 非活动窗格饱和度和亮度设置（HSB色彩空间）
        inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
}
╭─    ~/仓库/wezterm    main !11                                                                                             ✔  04:16:00  ─╮
╰─ clar                                                                                                                                               ─╯
zsh: correct 'clar' to 'clear' [nyae]? n
zsh: command not found: clar
╭─    ~/仓库/wezterm    main !11                                                                                         127 ✘  04:16:17  ─╮
╰─ cat config/appearance.lua                                                                                                                          ─╯
----------------------------------------------------------------------------------------
-- 终端美化配置                                                                       --
-- 作者:忘羽梦汐                                                                      --
-- 功能介绍:这个代码是WezTerm终端的窗口美化，终端字体，渲染，动画，背景配置，光标配置 --
----------------------------------------------------------------------------------------

local wezterm = require("wezterm")
local colors = require("colors.custom")
-- local fonts = require('config.fonts')

return {
        -- 终端仿真类型，支持 256 色
        term = "xterm-256color",

        -- 动画相关帧率设置
        animation_fps = 60, -- 动画每秒帧数
        max_fps = 60, -- 最大帧率限制

        -- 渲染相关配置
        front_end = "WebGpu", -- 使用 WebGPU 前端进行渲染（需要支持）
        webgpu_power_preference = "HighPerformance", -- 优先使用高性能 GPU

        -- 颜色方案设置（此处注释掉了自定义颜色，使用 Gruvbox 主题）
        -- colors = colors,
        color_scheme = "Gruvbox dark, medium (base16)",

        -- 背景设置
        window_background_opacity = 1.00, -- 窗口背景不透明度（1为完全不透明）
        win32_system_backdrop = "Acrylic", -- Windows 特有的半透明毛玻璃效果

        -- 背景渐变配置，线性渐变，角度为-45度
        window_background_gradient = {
                colors = { "#1D261B", "#261A25" },
                orientation = { Linear = { angle = -45.0 } },
        },

        -- 多层背景，第一层为图片，第二层为颜色覆盖（带透明度）
        background = {
                {
                        source = { File = wezterm.config_dir .. "/backdrops/astro-jelly.jpg" },
                },
                {
                        source = { Color = "#1A1B26" },
                        height = "100%",
                        width = "100%",
                        opacity = 0.95, -- 颜色覆盖层透明度
                },
        },

        -- 滚动条配置
        enable_scroll_bar = true, -- 启用滚动条
        min_scroll_bar_height = "3cell", -- 滚动条最小高度为3字符高度
        colors = {
                scrollbar_thumb = "#34354D", -- 滚动条滑块颜色
        },

        -- 标签栏配置
        enable_tab_bar = true, -- 启用标签栏
        hide_tab_bar_if_only_one_tab = false, -- 只有一个标签时不隐藏标签栏
        use_fancy_tab_bar = true, -- 启用花哨标签栏样式
        tab_max_width = 25, -- 标签最大宽度
        show_tab_index_in_tab_bar = true, -- 显示标签索引（序号）
        switch_to_last_active_tab_when_closing_tab = true, -- 关闭标签切换到上一个活跃标签

        -- 光标配置
        default_cursor_style = "BlinkingUnderline", -- 默认光标为闪烁下划线
        cursor_blink_ease_in = "Constant", -- 光标闪烁动画淡入效果
        cursor_blink_ease_out = "Constant", -- 光标闪烁动画淡出效果
        cursor_blink_rate = 700, -- 光标闪烁周期，单位毫秒

        -- 窗口配置
        adjust_window_size_when_changing_font_size = false, -- 调整字体大小时不自动调整窗口大小
        window_decorations = "INTEGRATED_BUTTONS|RESIZE", -- 窗口装饰，集成按钮和可调整大小
        integrated_title_button_style = "Windows", -- 标题栏按钮样式为 Windows 风格
        integrated_title_button_color = "auto", -- 标题栏按钮颜色自动
        integrated_title_button_alignment = "Right", -- 标题栏按钮靠右对齐

        -- 窗口初始大小
        initial_cols = 120, -- 初始列数
        initial_rows = 24, -- 初始行数

        -- 窗口内边距（单位为像素）
        window_padding = {
                left = 5,
                right = 10,
                top = 12,
                bottom = 7,
        },

        -- 关闭窗口时总是弹出确认提示
        window_close_confirmation = "AlwaysPrompt",

        -- 窗口框架颜色配置
        window_frame = {
                active_titlebar_bg = "#0F2536", -- 活动窗口标题栏背景色
                inactive_titlebar_bg = "#0F2536", -- 非活动窗口标题栏背景色
                -- font = fonts.font,               -- 标题栏字体（暂时注释）
                -- font_size = fonts.font_size,    -- 标题栏字体大小（暂时注释）
        },

        -- 非活动窗格饱和度和亮度设置（HSB色彩空间）
        inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
}

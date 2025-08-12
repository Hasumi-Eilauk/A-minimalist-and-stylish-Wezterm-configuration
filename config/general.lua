-----------------------------------------------------------------------------------------------------
-- wezterm行为配置                                                                                 --
-- 作者:忘羽梦汐                                                                                   --
-- 功能介绍:这段代码是 WezTerm 终端模拟器的配置片段，主要设置了一些行为选项、滚动条和超链接识别规则--
-----------------------------------------------------------------------------------------------------

-- 辅助函数：生成匹配特定括号包裹的 URL 的超链接规则
-- 参数:
--   open  - 左括号字符，如 "("
--   close - 右括号字符，如 ")"
-- 返回:
--   一个包含 regex（正则表达式）、format（格式化字符串）和 highlight（高亮级别）的表
local function bracket_rule(open, close)
        -- string.format 生成带转义的正则表达式，匹配 open 和 close 括号之间的 URL
        -- 例如：\((\w+://\S+)\)
        local pattern = string.format("\\%s(\\w+://\\S+)\\%s", open, close)
        return {
                regex = pattern, -- 匹配特定括号内的 URL
                format = "$1", -- 将匹配的 URL 内容作为超链接
                highlight = 1, -- 设置高亮级别为 1，强调显示
        }
end

return {
        -- 基础行为配置 --
        automatically_reload_config = true, -- 配置文件修改后自动重新加载，无需重启 wezterm
        check_for_updates = false, -- 关闭自动检测更新功能，避免启动延迟或提示
        exit_behavior = "CloseOnCleanExit", -- 当 shell 程序正常退出时关闭窗口（非异常退出）
        status_update_interval = 1000, -- 状态栏每隔1000毫秒刷新一次，保证状态信息实时更新

        -- 滚动条配置 --
        scrollback_lines = 5000, -- 设置终端滚动缓冲区行数为5000，方便查看历史输出

        -- 粘贴行为配置 --
        canonicalize_pasted_newlines = "CarriageReturn", -- 规范粘贴时的换行符，统一转换为回车符

        -- 超链接识别规则 --
        hyperlink_rules = {
                bracket_rule("(", ")"), -- 匹配被圆括号包裹的 URL，如 (https://example.com)
                bracket_rule("[", "]"), -- 匹配被方括号包裹的 URL，如 [https://example.com]
                bracket_rule("{", "}"), -- 匹配被大括号包裹的 URL，如 {https://example.com}
                bracket_rule("<", ">"), -- 匹配被尖括号包裹的 URL，如 <https://example.com>

                -- 匹配没有括号包裹的 URL，确保链接仍然可点击
                {
                        regex = [[\b\w+://\S+[)/a-zA-Z0-9-]+]], -- 以协议开头，后面跟非空白字符，结尾允许包括括号或字母数字等
                        format = "$0", -- 直接将匹配的整个字符串作为超链接
                },

                -- 匹配电子邮件地址，将其自动转化为 mailto 链接
                {
                        regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]], -- 标准邮箱格式：username@domain.tld
                        format = "mailto:$0", -- 生成 mailto: 前缀的超链接
                },
        },
}

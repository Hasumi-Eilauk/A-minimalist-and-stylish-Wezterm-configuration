---------------------------------------------------------------------------------------------------------------
-- wezterm默认启动shell配置                                                                                  --
-- 作者:忘羽梦汐                                                                                             --
-- 功能介绍:这段代码是一个基于当前操作系统平台（Windows、macOS、Linux）动态配置的终端启动程序（default_prog  --
--          和启动菜单项（launch_menu）的配置表，常用于终端模拟器（比如 WezTerm）中                          --
---------------------------------------------------------------------------------------------------------------

local platform = require("utils.platform")()

local icons = {
        bash = "",
        zsh = "",
        ohmyzsh = "",
        fish = "",
        powershell = "",
        cmd = "",
}

local options = {
        default_prog = {},
        launch_menu = {},
}

if platform.is_win then
        -- Windows 默认启动 cmd
        options.default_prog = { "cmd" }
        options.launch_menu = {
                { label = icons.cmd .. " Cmd", args = { "cmd" } },
                { label = icons.powershell .. " PowerShell", args = { "powershell" } },
        }
elseif platform.is_mac or platform.is_linux then
        -- macOS 和 Linux 默认启动 zsh
        options.default_prog = { "zsh", "--login" }
        options.launch_menu = {
                { label = icons.bash .. " Bash", args = { "bash", "--login" } },
                { label = icons.zsh .. " Zsh", args = { "zsh", "--login" } },
                { label = icons.ohmyzsh .. " Oh-My-Zsh", args = { "zsh", "--login", "-i", "-c", "source ~/.zshrc" } },
                { label = icons.fish .. " Fish", args = { "fish", "--login" } },
        }
end

return options

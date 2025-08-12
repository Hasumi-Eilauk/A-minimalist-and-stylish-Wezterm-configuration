local Config = require("config")

require("events.right-status").setup()
require("events.tab-title").setup()
require("events.new-tab-button").setup()

local base_config = Config:init()
        :append(require("config.appearance"))
        :append(require("config.bindings"))
        :append(require("config.domains"))
        :append(require("config.fonts"))
        :append(require("config.general"))
        :append(require("config.launch")).options

-- 添加鼠标右键粘贴模块
base_config.mouse_bindings = base_config.mouse_bindings or {}

table.insert(base_config.mouse_bindings, {
        event = { Up = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = require("wezterm").action.PasteFrom("Clipboard"),
})

return base_config

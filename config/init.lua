-----------------------------------------------------------------------------------------------------------------------------------------
-- wezterm模块管理                                                                                                                     --
-- 作者:忘羽梦汐                                                                                                                       --
-- 功能介绍:这段代码定义了一个用于管理 WezTerm 配置的 Lua 模块 Config，它实现了一个可追加配置项的配置管理结构，便于组织和合并多个配置表--
-----------------------------------------------------------------------------------------------------------------------------------------

local wezterm = require("wezterm")

---@class Config
---@field options table
local Config = {}

--- 创建并返回一个 Config 实例
---@return Config
function Config:init()
	local o = { options = {} }
	return setmetatable(o, { __index = Config })
end

--- 追加配置到 options 中
--- 遇到重复键时会打印警告，但不会覆盖已有值
---@param new_options table 新配置项表
---@return Config self，支持链式调用
function Config:append(new_options)
	for k, v in pairs(new_options) do
		if self.options[k] ~= nil then
			wezterm.log_warn("Duplicate config option detected: ", { old = self.options[k], new = v })
		else
			self.options[k] = v
		end
	end
	return self
end

return Config

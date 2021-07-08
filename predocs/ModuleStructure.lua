-- I use @see of emmylua to avoid some bugs during doc generation

---@class module
---@see [Optional] Check "BetterCommands" folder'
---@field public commands? table<string, function>
---@see [Optional]
---@field public on_nth_tick? table<number, function>
---@see [Optional]
--- All events of https://lua-api.factorio.com/latest/events.html#All%20events except on_nth_tick
---@field public events? table<number|string, function>
local M = {}


--- [Optional]
--- Analog of script.on_init(function)
function M:on_init() end

--- [Optional]
--- Analog of script.on_load(function)
function M:on_load() end

--- [Optional]
--- Analog of script.on_configuration_changed(function)
function M:on_configuration_changed() end

--- [Optional]
--- Safe disabling of this mod remotely on init stage (see control.lua for details)
function M:update_global_data_on_disabling() end


return M

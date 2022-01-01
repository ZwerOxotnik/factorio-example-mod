
if script.level.campaign_name then return end -- Don't init if it's a campaign
if script.level.level_name == "sandbox" then return end -- Don't init if it's "sandbox" scenario

require("defines")


---@type table<string, module>
local modules = {}
modules.better_commands = require("models/BetterCommands/control")
modules.example_module = require("models/example-module")
modules.data_consistency_example = require("models/data-consistency-example")
-- modules.empty_module = require("models.empty-module")


-- Safe disabling of this mod remotely on init stage
-- Useful for other map developers and in some rare cases for mod devs
if remote.interfaces["disable-" .. script.mod_name] then
	for _, module in pairs(modules) do
		local update_global_data_on_disabling = module.update_global_data_on_disabling
		module.events = nil
		module.on_nth_tick = nil
		module.commands = nil
		module.on_load = nil
		module.add_remote_interface = nil
		module.add_commands = nil
		module.on_configuration_changed = update_global_data_on_disabling
		module.on_init = update_global_data_on_disabling
	end
else
	modules.better_commands:handle_custom_commands(modules.example_module) -- adds commands
end


local event_handler
if script.active_mods["zk-lib"] then
	-- Same as Factorio "event_handler", but slightly better performance
	event_handler = require("__zk-lib__/static-libs/lualibs/event_handler_vZO.lua")
else
	event_handler = require("event_handler")
end

event_handler.add_libraries(modules)

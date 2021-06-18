
if script.level.campaign_name then return end -- Don't init if it's a campaign
if script.level.level_name == "sandbox" then return end -- Don't init if it's "sandbox" scenario

require("defines")
local event_handler = require("event_handler")
local modules = {}
modules.command_wrapper = require("models/command-wrapper/control")
modules.example_module = require("models/example-module")
-- modules.empty_module = require("models.empty-module")


-- Safe disabling of this mod remotely on init stage
-- Useful for other map developers and in some rare cases for mod devs
if remote.interfaces["disable-" .. script.level.mod_name] then
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
end


modules.command_wrapper.handle_custom_commands(modules.example_module) -- adds commands

event_handler.add_libraries(modules)

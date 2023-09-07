MAKE_DEFINE_GLOBAL = true
require("__example-mod__/defines") -- It's possible to get lua files from other mods
local event_handler = require("event_handler")

---@type table<string, module>
local modules = {}
modules.example_module = require("models/example-module")
modules.stop_example_mod = require("models/stop-example-mod")


--- Adds https://github.com/ZwerOxotnik/factorio-BetterCommands if exists
if script.active_mods["BetterCommands"] then
	local is_ok, better_commands = pcall(require, "__BetterCommands__/BetterCommands/control")
	if is_ok then
		better_commands.COMMAND_PREFIX = MOD_SHORT_NAME
		modules.better_commands = better_commands
		if better_commands.handle_custom_commands then
			better_commands.handle_custom_commands(modules.example_module) -- adds commands
		end
	end
end


event_handler.add_libraries(modules)

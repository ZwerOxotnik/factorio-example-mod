
require("__example-mod__/defines")
local event_handler = require("event_handler")

---@type table<string, module>
local modules = {}
modules.better_commands = require(MOD_PATH .. "/models/BetterCommands/control")
modules.example_module = require("models/example-module")
modules.stop_example_mod = require("models/stop-example-mod")


modules.better_commands:handle_custom_commands(modules.example_module) -- adds commands

event_handler.add_libraries(modules)

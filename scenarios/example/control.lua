
require("__example-mod__/defines")
local event_handler = require("event_handler")
local modules = {}
modules.command_wrapper = require(MOD_PATH .. "/models/command-wrapper/control")
modules.example_module = require("models/example-module")
modules.stop_example_mod = require("models/stop-example-mod")


modules.command_wrapper.handle_custom_commands(modules.example_module) -- adds commands

event_handler.add_libraries(modules)

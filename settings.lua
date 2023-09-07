-- See https://wiki.factorio.com/Tutorial:Mod_settings#Reading_settings

require("defines")


--- Adds settings for commands
if mods["BetterCommands"] then
	local is_ok, better_commands = pcall(require, "__BetterCommands__/BetterCommands/control")
	if is_ok then
		better_commands.COMMAND_PREFIX = MOD_SHORT_NAME
		better_commands.create_settings(MOD_PATH, MOD_SHORT_NAME) -- Adds switchable commands
	end
end


-- Just an example
-- https://wiki.factorio.com/Tutorial:Mod_settings#Creation
-- data:extend({
-- 	{
-- 			type = "int-setting",
-- 			name = "my-unique-setting",
-- 			setting_type = "startup", -- or runtime-global or runtime-per-user
-- 			minimum_value = 1,
-- 			maximum_value = 1000,
-- 			default_value = 100,
-- 			localised_name = {"Example"}, -- Optional
-- 			localised_description = {"Example"}, -- Optional
-- 			order = "any-order", -- Optional
--			hidden = false -- Optional (false by default)
-- 	}
-- })

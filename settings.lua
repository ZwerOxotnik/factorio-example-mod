-- See https://wiki.factorio.com/Tutorial:Mod_settings#Reading_settings

require("defines")
require("models/BetterCommands/control"):create_settings() -- Adds switchable commands


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

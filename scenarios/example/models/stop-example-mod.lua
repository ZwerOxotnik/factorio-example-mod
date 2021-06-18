--[[
	Safely disables another mod/script remotely on init stage
	Useful for other map developers and in some rare cases for mod devs
	But another mod must have such interface.

	See control.lua in the mod for other details.
]]
local module = {}
local mod_name = "disable-" .. MOD_NAME

remote.remove_interface(mod_name)
remote.add_interface(mod_name, {}) -- trying to disable another mod


-- Reversly using this method :)
-- Remove garbage
module.add_remote_interface = function()
	remote.remove_interface(mod_name)
	mod_name = nil
end


return module

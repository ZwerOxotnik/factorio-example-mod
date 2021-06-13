--[[
	Safely disabling anither mod/script remotely on init stage
	Useful for other map developers and in some rare cases for mod devs
	But another mod must have such interface
]]

local module = {}
local mod_name = "disable-another-mod"

remote.remove_interface(mod_name)
remote.add_interface(mod_name, {}) -- trying to disable another mod


-- Reversly using this method :)
-- Remove garbage
module.add_remote_interface = function()
	remote.remove_interface(mod_name)
	mod_name = nil
end


return module

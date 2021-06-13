--[[
	Safely disabling anither mod/script remotely on init stage
	Useful for other map developers and in some rare cases for mod devs
	But another mod must have such interface
]]

local module = {}
remote.add_interface("disable-another-mod", {}) -- trying to disable another mod


-- Reversly using this method :)
-- Remove garbage
module.add_remote_interface = function()
	remote.remove_interface("disable-another-mod")
end


return module

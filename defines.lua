-- Change everything in this file in your mod!
local _data = {
	MOD_NAME = "example-mod",
	MOD_PATH = "__example-mod__",

	-- Don't use symbols like '-' etc (it'll break pattern of regular expressions)
	MOD_SHORT_NAME = "em_",
	AUTHOR = "ZwerOxotnik"
}

if not MAKE_DEFINE_GLOBAL or (not IS_DATA_STAGE and script and script.active_mods) then
	return _data
end

--- Make content of _data global
for k, v in pairs(_data) do
	_ENV[k] = v
end

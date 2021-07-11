
-- Source: https://github.com/ZwerOxotnik/factorio-example-mod

---@class BetterCommands : module
local M = {}

---@type table<string, table>
local all_commands = {} -- commands from other modules

local MAX_INPUT_LENGTH = 500 -- set any number
local CONST_COMMANDS = require(MOD_PATH .. "/const-commands")
local SWITCHABLE_COMMANDS = require(MOD_PATH .. "/switchable-commands")


---@param s string
local function trim(s)
	return s:match'^%s*(.*%S)' or ''
end

---@return boolean
local function remove_command(command_name)
	if commands.remove_command(MOD_SHORT_NAME .. command_name) then
		return true
	else
		return commands.remove_command(command_name)
	end
end

---@param message string
---@param player_index? number
-- Sends message to a player or server
local function print_to_caller(message, player_index)
	if game == nil or player_index == nil or player_index == 0 then
		print(message) -- this message for server
	else
		local player = game.get_player(player_index)
		if player and player.valid then
			player.print(message)
		end
	end
end


---@param error_message string
---@param player_index? number
---@param command_name string
local function disable_setting(error_message, player_index, command_name)
	print_to_caller(error_message, player_index)

	local is_message_sended = false
	if game then
		for _, player in pairs(game.connected_players) do
			if player.valid and player.admin then
				player.print(error_message)
				is_message_sended = true
			end
		end
	end
	if is_message_sended == false then
		log(error_message)
	end

	-- Turns off the command
	if command_name then
		local setting_name = MOD_SHORT_NAME .. command_name
		if settings.global[setting_name] then
			settings.global[setting_name] = {
				value = false
			}
		end
	end
end

local player_input_type = 1
local team_input_type = 2
local input_types = {
	player = player_input_type,
	team = team_input_type
}

---@param command_settings table
---@param original_func function
---@return boolean
local function add_custom_command(command_settings, original_func)
	local input_type = input_types[command_settings.input_type]
	local is_allowed_empty_args = command_settings.is_allowed_empty_args
	local command_name = command_settings.name
	if commands.commands[command_name] then
		command_name = MOD_SHORT_NAME .. command_name
		if commands.commands[command_name] then
			return false
		end
	end

	local command_description = command_settings.description
	commands.add_command(command_name, command_description, function(cmd)
		if cmd.player_index == 0 then
			if command_settings.allow_for_server == false then
				print({"prohibited-server-command"})
				return
			end
		else
			local caller = game.get_player(cmd.player_index)
			if not (caller and caller.valid) then return end
			if command_settings.only_for_admin and caller.admin == false then
				caller.print({"command-output.parameters-require-admin"})
				return
			end
		end

		if cmd.parameter == nil then
			if is_allowed_empty_args == false then
				print_to_caller({"", '/' .. command_name .. ' ', command_description}, cmd.player_index)
				return
			end
		elseif #cmd.parameter > MAX_INPUT_LENGTH then
			print_to_caller({"", {"description.maximum-length", '=', MAX_INPUT_LENGTH}}, cmd.player_index)
			return
		end

		if cmd.parameter and input_type then
			if input_type == player_input_type then
				if #cmd.parameter > 32 then
					print_to_caller({"gui-auth-server.username-too-long"}, cmd.player_index)
					return
				else
					cmd.parameter = trim(cmd.parameter)
					local player = game.get_player(cmd.parameter)
					if not (player and player.valid) then
						print_to_caller({"player-doesnt-exist", cmd.parameter}, cmd.player_index)
						return
					end
				end
			elseif input_type == team_input_type then
				if #cmd.parameter > 52 then
					print_to_caller({"too-long-team-name"}, cmd.player_index)
					return
				else
					cmd.parameter = trim(cmd.parameter)
					local force = game.forces[cmd.parameter]
					if not (force and force.valid) then
						print_to_caller({"force-doesnt-exist", cmd.parameter}, cmd.player_index)
						return
					end
				end
			end
		end

		-- error handling
		local is_ok, error_message = pcall(original_func, cmd)
		if is_ok then
			return
		else
			disable_setting(error_message, cmd.player_index, command_name)
		end
	end)

	return true
end

---Handles commands of a module
---@param module module your module with commands
function M:handle_custom_commands(module)
	if module == nil then
		log("Parameter is nil")
		return false
	end
	if type(module.commands) ~= "table" then
		log("Current module doesn't have proper commands")
		return false
	end

	for _, added_commands in pairs(all_commands) do
		if added_commands == module.commands then
			log("Current commands was added before")
			return true
		end
	end
	table.insert(all_commands, module.commands)

	for command_name, func in pairs(module.commands) do
		local command_settings = SWITCHABLE_COMMANDS[command_name] or CONST_COMMANDS[command_name] or {}
		command_settings.name = command_settings.name or command_name
		local setting = nil
		if SWITCHABLE_COMMANDS[command_name] then
			setting = settings.global[MOD_SHORT_NAME .. command_name]
		end

		if setting == nil then
			local is_added = add_custom_command(command_settings, func)
			if is_added == false then
				log(script.level.mod_name .. " can't add command \"" .. command_settings.name .. "\"")
			end
		elseif setting.value then
			local is_added = add_custom_command(command_settings, func)
			if is_added == false then
				local message = script.level.mod_name .. " can't add command \"" .. command_settings.name .. "\""
				disable_setting(message, nil, command_name)
			end
		else
			remove_command(command_settings.name)
		end
	end

	return true
end

---@param command_name string original command name
---@return function
local function find_func_by_command_name(command_name)
	for _, some_commands in pairs(all_commands) do
		local func = some_commands[command_name]
		if func then
			return func
		end
	end
end

---@return boolean
local function on_runtime_mod_setting_changed(event)
	if event.setting_type ~= "runtime-global" then return end
	if string.find(event.setting, '^' .. MOD_SHORT_NAME) ~= 1 then return end

	local command_name = string.gsub(event.setting, '^' .. MOD_SHORT_NAME, "")
	local func = find_func_by_command_name(command_name) -- WARNING: check this throughly!
	if func == nil then
		log("Didn't find '" .. command_name .. "' among commands in modules")
	end
	local command_settings = SWITCHABLE_COMMANDS[command_name] or {}
	local state = settings.global[event.setting].value
	command_settings.name = command_settings.name or command_name
	if state == true then
		local is_added = add_custom_command(command_settings, func)
		if is_added then
			game.print("Added command: " .. command_settings.name or command_name)
		else
			local message = script.level.mod_name .. " can't add command \"" .. command_settings.name .. "\""
			disable_setting(message, nil, command_name)
		end
	else
		remove_command(command_settings.name or command_name)
		game.print("Removed command: " .. command_settings.name or command_name)
	end

	return true
end


--- Adds settings for commands, so we can disable commands by settings
--- Use it during setting stage
function M:create_settings()
	local new_settings = {}
	for key, command in pairs(SWITCHABLE_COMMANDS) do
		local command_name = command.name or key
		new_settings[#new_settings + 1] = {
			type = "bool-setting",
			name = MOD_SHORT_NAME .. key,
			setting_type = "runtime-global",
			default_value = command.default_value or true,
			localised_name = '/' .. command_name,
			localised_description = command.description or ""
		}
	end
	if #new_settings > 0 then
		data:extend(new_settings)
	end
end


M.events = {
	[defines.events.on_runtime_mod_setting_changed] = on_runtime_mod_setting_changed
}


return M

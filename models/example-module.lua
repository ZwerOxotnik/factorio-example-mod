
---@class ExampleModule : module
local M = {}


---@type table<string, number> https://lua-api.factorio.com/latest/LuaBootstrap.html#LuaBootstrap.generate_event_name
local custom_events = {
	custom_event1 = script.generate_event_name() -- Don't use in any events, it'll cause desyncs
}

--#region Global data
local players_data
--#endregion


--#region Constants
local ABS = math.abs
--#endregion


function say_hello()
	game.print("Hello")
end

--#region Functions of events

local function on_player_created(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then return end

	global.message_for_new_player = "Events of example mod works fine"
	player.print(global.message_for_new_player)

	if player.admin then
		player.print("\nYou can access to mods by their \"name\" as a prefix for commands. For example: __example-mod__ global.test = 1")
		player.print("\nYou can use global functions from mods via console during the game.\nType it in console to try it: /c say_hello()")
		player.print("\nAlso, you can read and change mod global data via console during the game." ..
			"\nType it in console: /c __example-mod__ game.print(serpent.block(global))"
		)
		player.print("\nAnything can use \"remote interfaces\" and I created one as \"example-mod\" " ..
			"(any name can be used. Usually, it uses to get custom events from a mod)," ..
			"\nIt's safe to use anywhere if mods handled it determinately, otherwise it'll cause desync for other players. " ..
			"It can improve compability with other mods etc, although there are some restrictions." ..
			"\nLet's try it: /c remote.call(\"example-mod\", \"say_hello\")" ..
			"\nAnd this: /c  remote.call(\"example-mod\", \"get_event_name\", \"custom_event1\")"
		)
	end
end

--#endregion


--#region Commands

local function delete_example_UI_command(cmd)
	if cmd.player_index == 0 then -- server
		print("Deleted UIs")
	else
		local player = game.get_player(cmd.player_index)
		if not player.admin then
			player.print({"command-output.parameters-require-admin"})
			return
		end
		player.print("Deleted UIs")
	end

	for _, player in pairs(game.players) do
		if player.valid then
			-- destroy_UIs(player)
		end
	end
end

--#endregion


--#region Pre-game stage

local interface = {
	get_event_name = function(name)
		-- return custom_events[name] -- usually, it's enough
		game.print("ID: " .. tostring(custom_events[name]))
	end,
	say_hello = say_hello
}

local function add_remote_interface()
	-- https://lua-api.factorio.com/latest/LuaRemote.html
	remote.remove_interface("example-mod") -- For safety
	remote.add_interface("example-mod", interface)
end
-- You can create interface outside events
-- However, the game have to "load" with the mod in order to use functions of the interface
remote.add_interface("example-mod", interface)


local function link_data()
	players_data = global.players
end

local function update_global_data()
	global.players = global.players or {}

	link_data()

	for player_index, player in pairs(game.players) do
		-- delete UIs
	end
end


M.on_init = update_global_data
M.on_configuration_changed = update_global_data
M.on_load = link_data
M.update_global_data_on_disabling = update_global_data -- for safe disabling of this mod
M.add_remote_interface = add_remote_interface

--#endregion


M.events = {
	-- [defines.events.on_game_created_from_scenario] = on_game_created_from_scenario,
	-- [defines.events.on_gui_click] = on_gui_click,
	[defines.events.on_player_created] = on_player_created,
	-- [defines.events.on_player_joined_game] = on_player_joined_game,
	-- [defines.events.on_player_left_game] = on_player_left_game,
	-- [defines.events.on_player_removed] = delete_player_data,
	-- [defines.events.on_player_changed_surface] = clear_player_data,
	-- [defines.events.on_player_respawned] = clear_player_data,
	-- [defines.events.on_gui_value_changed] = on_gui_value_changed, -- please, don't use it. It impacts UPS significantly
}

-- M.on_nth_tick = {
-- 	[50] = function()
-- 		for player_index, _ in pairs(game.connected_players) do
-- 			pcall(update_stuff, player_index)
-- 		end
-- 	end,
-- }

M.commands = {
	delete_example_UI = delete_example_UI_command,
}


return M

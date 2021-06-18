
local module = {}


--#region Global data
local players_data
--#endregion


--#region Constants
local ABS = math.abs
--#endregion


--#region Functions of events

local function on_player_created(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then return end

	player.print("Events of example mod works fine")
end

local function on_game_created_from_scenario(event)
	-- ########
	-- Some examples of code what you can do with this event below
	-- Some interaction with game ignores (i.q: game.print("loaded scenario"))
	-- ########

	-- disable_recipes()

	-- if global.biters_destination == nil then
	-- 	local target = game.get_entity_by_tag("target")
	-- 	global.biters_destination = target.position
	-- 	biters_destination = global.biters_destination
	-- 	if global.target_id == nil and target then
	-- 		global.target_id = script.register_on_entity_destroyed(target)
	-- 	end
	-- end

	-- local biters_spawn
	-- biters_spawn = game.get_entity_by_tag("biters_spawn_1")
	-- global.biters_spawn_position_1 = global.biters_spawn_position_1 or biters_spawn.position
	-- biters_spawn_position_1 = global.biters_spawn_position_1
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

local function link_data()
	players_data = global.players
end

local function update_global_data()
	global.players = global.players or {}

	for player_index, player in pairs(game.players) do
		-- delete UIs
	end
end


module.on_init = (function()
	update_global_data()
	link_data()
end)

module.on_load = (function()
	link_data()
end)

module.on_configuration_changed = (function()
	update_global_data()
	link_data()
end)
module.update_global_data_on_disabling = update_global_data -- for safe disabling of this mod

--#endregion


---@type table<number, function>
-- [optional]
-- All events of https://lua-api.factorio.com/latest/events.html#All%20events except on_nth_tick
module.events = {
	[defines.events.on_game_created_from_scenario] = on_game_created_from_scenario,
	-- [defines.events.on_gui_click] = on_gui_click,
	[defines.events.on_player_created] = on_player_created,
	-- [defines.events.on_player_joined_game] = on_player_joined_game,
	-- [defines.events.on_player_left_game] = on_player_left_game,
	-- [defines.events.on_player_removed] = delete_player_data,
	-- [defines.events.on_player_changed_surface] = clear_player_data,
	-- [defines.events.on_player_respawned] = clear_player_data,
	-- [defines.events.on_gui_value_changed] = on_gui_value_changed, -- please, don't use it. It impacts UPS significantly
}

---@type table<number, function>
-- [optional]
-- module.on_nth_tick = {
-- 	[50] = function()
-- 		for player_index, _ in pairs(game.connected_players) do
-- 			pcall(update_stuff, player_index)
-- 		end
-- 	end,
-- }


---@type table<string, function>
-- [optional]
-- Check "command-wrapper" folder
module.commands = {
	delete_example_UI = delete_example_UI_command,
}


return module

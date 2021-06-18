
local module = {}


--#region Global data
--local players_data
--#endregion


--#region Constants
--local ABS = math.abs
--#endregion


--#region Functions of events

local function on_game_created_from_scenario(event)

end

--#endregion


--#region Pre-game stage

local function link_data()
	--players_data = global.players
end

local function update_global_data()
	--global.players = global.players or {}
	--
	--for player_index, player in pairs(game.players) do
	--	-- delete UIs
	--end
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
module.update_global_data_on_disabling = update_global_data -- for safe disabling

--#endregion


---@type table<number|string, function>
-- [optional]
-- All events of https://lua-api.factorio.com/latest/events.html#All%20events except on_nth_tick
module.events = {
	--[defines.events.on_game_created_from_scenario] = on_game_created_from_scenario,
	--[defines.events.on_gui_click] = on_gui_click,
	--[defines.events.on_player_created] = on_player_created,
	--[defines.events.on_player_joined_game] = on_player_joined_game,
	--[defines.events.on_player_left_game] = on_player_left_game,
	--[defines.events.on_player_removed] = delete_player_data,
	--[defines.events.on_player_changed_surface] = clear_player_data,
	--[defines.events.on_player_respawned] = clear_player_data,
}


---@type table<string, function>
-- [optional]
-- Check folder "command-wrapper"
module.commands = {
	-- set_spawn = set_spawn_command, -- Delete this example
}


return module

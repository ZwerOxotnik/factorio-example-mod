
---@class EmptyModule : module
local M = {}


--#region Global data
--local _players_data
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
	--_players_data = global.players
end

local function update_global_data()
	--global.players = global.players or {}
	--

	link_data()

	--for player_index, player in pairs(game.players) do
	--	-- delete UIs
	--end
end


M.on_init = update_global_data
M.on_configuration_changed = update_global_data
M.on_load = link_data
M.update_global_data_on_disabling = update_global_data -- for safe disabling of this mod

--#endregion


M.events = {
	--[defines.events.on_game_created_from_scenario] = on_game_created_from_scenario,
	--[defines.events.on_gui_click] = on_gui_click,
	--[defines.events.on_player_created] = on_player_created,
	--[defines.events.on_player_joined_game] = on_player_joined_game,
	--[defines.events.on_player_left_game] = on_player_left_game,
	--[defines.events.on_player_removed] = delete_player_data,
	--[defines.events.on_player_changed_surface] = clear_player_data,
	--[defines.events.on_player_respawned] = clear_player_data,
}

M.commands = {
	-- set_spawn = set_spawn_command, -- Delete this example
}


return M

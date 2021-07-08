--[[
	This is just a particular example, not a guide. You don't have to follow this example forever!

	We gonna use https://lua-api.factorio.com/latest/Global.html to store data and some local table for singleplayer in some cases.

	There are some subtle differences between singleplayer and multiplayer.
	For instance: when a player start a map in singleplayer, the script won't use some events:
		defines.events.on_player_joined_game -- it works only when a player joins first time in singleplayer
		defines.events.on_player_left_game

	That leads some issues in other events.
	Usually, it's not a problem if data doesn't depend on those events or some related data isn't empty.
	We might use on_init and on_configuration_changed to always have some data.
	But it depends on your cases etc.

	So, in this example, we don't store data in global for players when they are offline and we're not going to "adapt" the data for singleplayer.
]]

---@class DataConsistencyExample : module
local M = {}


--#region Singleplayer data
-- Usually, some tables here (it's like a mirror of global data for singleplayer)
local sp_player_data = {}
--#endregion


--#region Global data
local players_data
--#endregion

--#region Functions of events

local function on_player_joined_game(event)
	local player_index = event.player_index
	local player = game.get_player(player_index)
	if not (player and player.valid) then return end

	-- Trying to simulate "loaded" game without this mod (otherwise I have to tell you about other cases)
	if game.is_multiplayer() then
		players_data[player_index] = {}
	end
end

local function delete_player_data(event)
	players_data[event.player_index] = nil
end

local function on_cancelled_deconstruction(event)
	local player_index = event.player_index
	local player = game.get_player(player_index)
	if not (player and player.valid) then return end

	local data = players_data[player_index] or sp_player_data
	-- You might get rid of second variable but, sometimes, it'll lead to more complex code or less performance

	data[#data] = math.random(100) -- it's safe to generate random numbers in multiplayer
	player.print("Data: " .. serpent.line(data))
	-- Let's check the result
	if players_data[player_index] == nil then
		player.print("Nothing in global data for player, using \"singleplayer\" data")
	else
		player.print("Using global to store the data")
	end
end

--#endregion


--#region Pre-game stage

-- You might get rid of this, but it's convenient to have and use
local function link_data()
	players_data = global.players
end

local function update_global_data()
	global.players = global.players or {}

	for player_index, _ in pairs(game.players) do
		global.players[player_index] = nil
	end
end


M.on_init = (function()
	update_global_data()
	link_data()
end)

M.on_load = (function()
	link_data()
end)

M.on_configuration_changed = (function()
	update_global_data()
	link_data()
end)

M.update_global_data_on_disabling = update_global_data -- for safe disabling

--#endregion


M.events = {
	--[defines.events.on_player_created] = on_player_created, -- it might be useful
	[defines.events.on_player_joined_game] = on_player_joined_game,
	[defines.events.on_player_left_game] = delete_player_data,
	[defines.events.on_player_removed] = delete_player_data,
	[defines.events.on_cancelled_deconstruction] = on_cancelled_deconstruction
}

M.commands = {
	-- set_spawn = set_spawn_command, -- Delete this example
}


return M

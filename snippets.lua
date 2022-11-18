---- Safe teleportation for players
local surface = game.get_surface(1)
local target_position = {0, 0}
for _, player in pairs(game.players) do
	if player.valid then
		local character = player.character
		if not (character and character.valid) then
			player.teleport(target_position, surface)
		else
			local target
			local is_vehicle = false
			local vehicle = player.vehicle
			local target_name
			if vehicle and not vehicle.train and vehicle.get_driver() == character and vehicle.get_passenger() == nil then
				target = vehicle
				target_name = vehicle.name
				is_vehicle = true
			else
				target = player
				target_name = character.name
			end
			local radius = 200
			local non_colliding_position = surface.find_non_colliding_position(target_name, target_position, radius, 1)

			if non_colliding_position then
				if is_vehicle then
					if vehicle.type == "spider-vehicle" then
						target.stop_spider()
					else
						target.speed = 0
					end
				end
				target.teleport(non_colliding_position, surface)
			else
				player.print("It's not possible to teleport you because there's not enough space for your character")
			end
		end
	end
end

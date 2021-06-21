-- Please, read https://lua-api.factorio.com/latest/Migrations.html

for _, force in pairs(game.forces) do
	force.reset_recipes()
	force.reset_technologies()
	force.technologies["logistics-3"].researched = true
end

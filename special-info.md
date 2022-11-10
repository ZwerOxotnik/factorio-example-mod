## Please, always do this:
```lua
local DESTROY_SETTINGS = {raise_destroy=true}
entity.destroy(DESTROY_SETTINGS)
```
## Instead of this:
```lua
entity.destroy()
```
Otherwise, you'll break many mods.

#

## This is faster than
```lua
/measured-command
local tiles = {}
local c = 0
for i = -1000, 1000 do
    for j = -1000, 1000 do
        c = c + 1
        tiles[c] = {position = {i, j}, name = "refined-concrete"}
        if c > 1024 then
            game.player.surface.set_tiles(tiles, false, false, false)
            c = 0
        end
    end
end
game.player.surface.set_tiles(tiles, false, false, false)
```

## this
```lua
/measured-command
local tiles = {}
local c = 0
for i = -1000, 1000 do
    for j = -1000, 1000 do
        c = c + 1
        tiles[c] = {position = {i, j}, name = "refined-concrete"}
    end
end
game.player.surface.set_tiles(tiles, false, false, false)
```

So could use it with [surface.clone_area()](https://lua-api.factorio.com/latest/LuaSurface.html#LuaSurface.clone_area) to make things even faster (it takes a lot of time).

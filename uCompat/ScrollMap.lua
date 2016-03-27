--[[
		Scrollps related µLua compatibility layer/lib for ctrµLua
]]

-- Local

map = require("ctr.gfx.map")

-- Module

require("uCompat.screen")
require("uCompat.Map")

ScrollMap = {}

function ScrollMap.new(image, mapFile, width, height, tileWidth, tileHeight)
	local tiles = Map.mapToTable(mapFile, width, height)
	local m = map.load(tiles, image.texture, tileWidth, tileHeight)
	return {
		map = m,
		scrollX = 0,
		scrollY = 0,
		tileWidth = tileWidth,
		tileHeight = tileHeight,
	}
end

function ScrollMap.destroy(m)
	m.map:destroy()
end

function ScrollMap.draw(scr, m)
	local stack = screen.getStack(scr)
	local offsetX, offsetY = screen.offset()
	
	stack[#stack+1] = {"map", m.map, {offsetX+m.scrollX, offsetY+m.scrollY}}
end

function ScrollMap.scroll(m, x, y)
	m.scrollX = x
	m.scrollY = y
end

function ScrollMap.setTile(m, x, y, t)
	m.map:setTile(x, y, t)
end

function ScrollMap.getTile(m, x, y)
	return m.map:getTile(x, y)
end

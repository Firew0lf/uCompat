--[[
		Maps related µLua compatibility layer/lib for ctrµLua
]]

-- Local

map = require("ctr.gfx.map")

-- Module

require("uCompat.screen")

Map = {}

function Map.new(image, mapFile, width, height, tileWidth, tileHeight)
	local m = map.load(mapFile, image.texture, tileWidth, tileHeight)
	
	return {
		map = m,
		scrollX = 0,
		scrollY = 0,
		tileWidth = tileWidth,
		tileHeight = tileHeight,
	}
end

function Map.destroy(m)
	m.map:unload()
end

function Map.draw(scr, m, x, y, w, h)
	local stack = screen.getStack(scr)
	local offsetX, offsetY = screen.offset()
	
	stack[#stack+1] = {"map", m.map, {offsetX+(x*math.floor(m.scrollX*m.tileWidth)), offsetY+(y*math.floor(m.scrollY*m.tileHeight))}}
end

function Map.scroll(m, x, y)
	m.scrollX = x
	m.scrollY = y
end

function Map.space(m, x, y)
	m.map:setSpace(x, y)
end

function Map.setTile(m, x, y, t)
	m.map:setTile(x, y, t)
end

function Map.getTile(m, x, y)
	return m.map:getTile(x, y)
end

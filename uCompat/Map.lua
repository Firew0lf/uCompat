--[[
		Maps related µLua compatibility layer/lib for ctrµLua
]]

-- Local

local map = require("ctr.gfx.map")

require("uCompat.System")

-- Module
Map = {}

function Map.mapToTable(filename, w, h)
	local f = assert(io.open(filename, "r"))
	local data = f:read("a")
	f:close()
	
	local buff = {}
	local word
	for word in string.gmatch(data, "(%d)|\n*") do
		buff[#buff+1] = tonumber(word)
		if #buff == w*h then break end
	end
	
	local t = {}
	local x,y
	for y=1, h do
		t[y] = {}
		for x=1, w do
			t[y][x] = buff[x+((y-1)*w)]
		end
	end
	
	return t
end

-- Module

require("uCompat.screen")

function Map.new(image, mapFile, width, height, tileWidth, tileHeight)
	local tiles = mapToTable(System.fixPath(mapFile), width, height)
	local m = map.load(tiles, image.texture, tileWidth, tileHeight)
	
	return {
		map = m,
		scrollX = 0,
		scrollY = 0,
		tileWidth = tileWidth,
		tileHeight = tileHeight,
	}
end

function Map.destroy(m)
	-- This `if` should not exist.
	if m then	m.map:unload() end -- got some crashes here ... We should ban global values in Lua.
end

function Map.draw(scr, m, x, y, w, h)
	local stack = screen.getStack(scr)
	local offsetX, offsetY = screen.offset()
	
	stack[#stack+1] = {"map", m.map, {offsetX+(x*math.floor(m.scrollX*m.tileWidth)), offsetY+(y*math.floor(m.scrollY*m.tileHeight))}}
end

function Map.scroll(m, x, y)
	m.scrollX = (0-x)
	m.scrollY = (0-y)
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

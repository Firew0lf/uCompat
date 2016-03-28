--[[
		System related µLua compatibility layer/lib for ctrµLua
	
	The System table must not exist.
]]

-- Local

local fs = require("ctr.fs")
local gfx = require("ctr.gfx")

-- µ -> ctrµ
local function fixPath(DSpath)
	local path
	if DSpath:sub(1, 5) == "fat:/" then -- fix root
		path = ("sdmc:/"..DSpath:sub(6, -1))
	elseif DSpath:sub(1, 1) == "/" then
		path = ("sdmc:"..DSpath)
	elseif DSpath:sub(1, 5) == "efs:/" then
		path = ("romfs:/"..DSpath:sub(6,-1))
	elseif DSpath:sub(1, 2) ~= "./" then
		path = (fs.getDirectory()..DSpath)
	else
		path = DSpath
	end
	
	if path:sub(-1,-1) ~= "/" then
		path = (path.."/")
	end
	
	return path
end

-- ctrµ -> µ
local function unfixPath(path)
	local DSpath
	if path:sub(1, 6) == "sdmc:/" then
		DSpath = ("fat:/"..path:sub(7, -1))
	elseif path.sub(1, 1) == "/" then
		DSpath = ("fat:"..path)
	elseif path:sub(1, 7) == "romfs:/" then
		DSpath = ("efs:/"..path:sub(8, -1))
	end
	
	return DSpath
end

-- Constants

LED_ON = 0
LED_BLINK = 1
LED_SLEEP = 2

-- Module

System = {}

System.EFS = false

function System.currentDirectory()
	return unfixPath(fs.getDirectory())
end

function System.changeDirectory(dir)
	fs.setDirectory(fixPath(dir))
end

function System.remove(path)

end

function System.rename(old, new)

end

function System.makeDirectory(name)

end

function System.listDirectory(path)
	
	local list = fs.list(fixPath(path))
	local flist = {}
	for i=1, #list do
		flist[i] = {
			name = list[i].name,
			isDir = list[i].isDirectory,
			size = list[i].fileSize
		}
	end
	
	return flist
end

function System.CurrentVramUsed()
	return (6291456-gfx.vramSpaceFree())
end

function System.CurrentVramFree()
	return gfx.vramSpaceFree()
end

function System.CurrentPalUsed()
	return 0
end

function System.CurrentPalFree()
	return 0
end

function System.setLedBlinkMode(mode)

end

function System.shutDown()

end

function System.sleep()

end

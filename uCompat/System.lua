--[[
		System related µLua compatibility layer/lib for ctrµLua
	
	The System table must not exist.
]]

-- Local

local fs = require("ctr.fs")
local gfx = require("ctr.gfx")

-- Constants

LED_ON = 0
LED_BLINK = 1
LED_SLEEP = 2

-- Module

System = {}

function System.currentDirectory()
	return fs.getDirectory()
end

function System.changeDirectory(dir)
	fs.setDirectory(dir)
end

function System.remove(path)

end

function System.rename(old, new)

end

function System.makeDirectory(name)

end

function System.listDirectory(path)
	local list = fs.list(path)
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

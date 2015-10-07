--[[
		Controls related µLua compatibility layer/lib for ctrµLua

	Warning: this HID library will give you headaches. Really.
]]

-- Surprise

require("uCompat.screen") -- needed for the stylus offset

-- Local

local ctr = require("ctr")
local hid = require("ctr.hid")

local dsKeys = {["A"] = "a", ["B"] = "b", ["X"] = "x", ["Y"] = "y",
	["L"] = "l", ["R"] = "r", ["Start"] = "start", ["Select"] = "select",
	["Up"] = "up", ["Down"] = "down", ["Left"] = "left", ["Right"] = "right"}

dblcFreq = 30 -- Stylus double click timer, in frames
stylusX = 0 -- \ Both for Stylus.deltaX
stylusY = 0 -- /
stylusTime = 0

-- Module

Keys = {}
Keys.held = {}
Keys.released = {}
Keys.newPress = {}
Stylus = {}

Controls = {}

function Controls.read()
	hid.read()
	local k = hid.keys()
	
	for n,v in pairs(dsKeys) do
		Keys.held[n] = k.held[v]
		Keys.released[n] = k.up[v]
		Keys.newPress[n] = k.down[v]
	end
	
	Stylus.X, Stylus.Y = hid.touch()
	local offsetX, offsetY = screen.offset()
	if screen.getMainLcd() then offsetX = (offsetX-40) end
	Stylus.X = (Stylus.X - offsetX)
	if Stylus.X < 0 or Stylus.X > 255 then Stylus.X = stylusX end
	Stylus.Y = (Stylus.Y - offsetY)
	if Stylus.Y < 0 or Stylus.Y > 191 then Stylus.Y = stylusY end
	Stylus.deltaX = (stylusX-Stylus.X)
	Stylus.deltaY = (stylusY-Stylus.Y)
	stylusX, stylusY = Stylus.X, Stylus.Y
	
	Stylus.held = k.held.touch
	Stylus.released = k.up.touch
	Stylus.newPress = k.down.touch
	
	if k.down.touch and (ctr.time()-stylusTime)*(1000/(NB_FPS or 30)) > (dblcFreq/30) then
		Stylus.doubleClick = true
		stylusTime = ctr.time()
	elseif k.down.touch then
		stylusTime = ctr.time()
	end
	
end

function Controls.setStylusDblcFreq(freq)
	dblcFreq = freq
end

-- Initialize the thing
Controls.read()

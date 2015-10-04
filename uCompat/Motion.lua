--[[
		Motion related µLua compatibility layer/lib for ctrµLua

Nobody actually used this module. So please use directly the ctrµLua functions.
]]

-- Local

local hid = require("hid")

calX, calY, calZ = 0,0,0 -- for Motion.calibrate

-- Module

Motion = {}


function Motion.init()
	return true
end

function Motion.calibrate()
	hid.read()
	calX, calY, calZ = hid.gyro()
end

function Motion.readX()
	local x,y,z = hid.gyro()
	return (calX-x)
end

function Motion.readY()
	local x,y,z = hid.gyro()
	return (calY-y)
end

function Motion.readZ()
	local x,y,z = hid.gyro()
	return (calZ-z)
end

function Motion.accelerationX()
	local x,y,z = hid.accel()
	return x
end

function Motion.accelerationY()
	local x,y,z = hid.accel()
	return y
end

function Motion.accelerationZ()
	local x,y,z = hid.accel()
	return z
end

function Motion.readGyro()
	return (Motion.readX()*Motion.readY()*Motion.readZ())
end

function Motion.rotation()
	return (Motion.accelerationX()*Motion.accelerationY()*Motion.accelerationZ())
end

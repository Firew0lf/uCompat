--[[
		Nifi related µLua compatibility layer/lib for ctrµLua

	Actually use the IR port.
]]

-- Local

local ir = require("ctr.ir")

-- Module

Nifi = {}

function Nifi.init(channel)
	ir.init(channel+3)
	return true
end

function Nifi.changeChannel(channel)
	ir.setBitRate(channel+3)
end

function Nifi.stop()
	ir.shutdown()
end

function Nifi.checkMessage()
	if ir.receive(0) == "" then
		return true
	end
	return false
end

function Nifi.getTrame()
	return ir.receive()
end

function Nifi.sendMessage(message)
	ir.send(message, true)
end

function Nifi.readMessage()
	return ir.receive()
end


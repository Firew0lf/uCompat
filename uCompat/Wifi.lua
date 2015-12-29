--[[
		Wifi related µLua compatibility layer/lib for ctrµLua
	
	Only work for TCP sockets.
]]

-- Local

local socket = require("ctr.socket")

local meta = {
	__index = function(t, k)
		return function(...) end
	end
}

-- Module

Wifi = {}
setmetatable(Wifi, meta)

function Wifi.newAP()
	return {
		ssid = "",
		bssid = "",
		macaddr = "",
		channel = 0,
		rssi = 0,
		maxrate = 0,
		protection = "NONE",
		adhoc = false,
		active = false
	}
end

function Wifi.getAP(n)
	return 0
end

function Wifi.connectAP(n, nk, k)
	return -1 -- Connection ALWAYS refused
end

function Wifi.getLocalConf(c)
	if c == 1 then -- IP
		return "0.0.0.0"
	elseif c == 2 then -- Gateway
		return "0.0.0.0"
	elseif c == 3 then -- Subnet mask
		return "0.0.0.0"
	elseif c == 4 then -- First DNS
		return "0.0.0.0"
	elseif c == 5 then -- Second DNS
		return "0.0.0.0"
	elseif c == 6 then -- MAC
		return "0000000000"
	end
end

function Wifi.createTCPSocket()
	return socket.tcp()
end

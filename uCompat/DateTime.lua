--[[
		DateTime related µLua compatibility layer/lib for ctrµLua
]]

-- Local

-- Module

DateTime = {}

function DateTime.new()
	return {
		year = 0,
		month = 0,
		day = 0,
		hour = 0,
		minute = 0,
		second = 0
	}
end

function DateTime.getCurrentTime()
	return {
		year = tonumber(os.date("%Y")),
		month = tonumber(os.date("%m")),
		day = tonumber(os.date("%d")),
		hour = tonumber(os.date("%H")),
		minute = tonumber(os.date("%M")),
		second = tonumber(os.date("%S"))
	}
end

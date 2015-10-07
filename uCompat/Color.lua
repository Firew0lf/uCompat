--[[
	Colors related µLua compatibility layer/lib for ctrµLua
]]

-- Module

Color = {}

function Color.new(r, g, b)
	return (r+g*32+b*1024)
end

function Color.new256(r, g, b)
	r = math.floor(r*31/255)
	g = math.floor(g*31/255)
	b = math.floor(b*31/255)
	return (r+g*32+b*1024)
end

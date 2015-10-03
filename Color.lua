--[[
	Colors related µLua compatibility layer/lib for ctrµLua
]]

Color = {}

function Color.new(r, g, b)
	r = r*8
	g = g*8
	b = b*8
	return (r+g*256+b*65536)
end

function Color.new256(r, g, b)
	return (r+g*256+b*65536)
end

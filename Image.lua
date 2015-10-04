--[[
		Images related µLua compatibility layer/lib for ctrµLua
	
	Actually doesn't support GIFs, because sfillib doesn't. Use PNGs, these are
better.
]]

-- Local

local texture = require("ctr.gfx.texture")

-- Constants

RAM = texture.PLACE_RAM
VRAM = texture.PLACE_VRAM

-- Module

Image = {}

function Image.load(path, dest)
	local t = texture.load(path, dest)
	if not t then return nil end
	return { -- Image object
		texture = t,
		rotation = 0
	}
end

function Image.destroy(img)
	img.texture:unload()
	img = nil
end

function Image.width(img)
	local x,y = img.texture:getSize()
	return x
end

function Image.height(img)
	local x,y = img.texture:getSize()
	return y
end

function Image.scale(img, w, h)

end

function Image.rotate(img, angle, cx, cy)
	img.rotation = angle*((math.pi*2)/512)
end

function Image.rotateDegree(img, angle, cx, cy)
	img.rotation = angle*((math.pi*2)/360)
end

function Image.mirrorH(img, activate)

end

function Image.mirrorV(img. activate)

end

function Image.setTint(img, color)
	img.texture:setBlendColor(color*256)
end

